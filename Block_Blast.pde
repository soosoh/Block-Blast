//grid, colors
int[][] grid = new int[8][8];
ColorBox[][] colors = new ColorBox[8][8];
int x0 = 100;
int y0 = 100;

//pieces
boolean[] pieces = new boolean[]{true, true, true};
Block b1, b2, b3;

ColorBox search = new ColorBox(0, 0, 0);

public void setup()
{
  size(600, 800);
  
  //inital blocks
  b1 = new Block("l", 0);
  b2 = new Block("o", 1);
  b3 = new Block("i", 2);
  //TODO: add randomization also on reload
  
  //initialize colors
  for(int r = 0; r < grid.length; r++)
  {
    for(int c = 0; c < grid[r].length; c++)
    {
      colors[r][c] = search.getColor(0);
    }
  }
}

public void draw()
{
  background(54, 127, 245);
  noStroke();
  
  ColorBox cBox;
  
  //initial colors
  for(int r = 0; r < grid.length; r++)
  {
    for(int c = 0; c < grid[r].length; c++)
    {
      colors[r][c] = search.getColor(grid[r][c]);
    }
  }
  
  //snap
  if(pieces[0])
  {
    mainSnap(b1, 0);
  }
  if(pieces[1])
  {
    mainSnap(b2, 1);
  }
  if(pieces[2])
  {
    mainSnap(b3, 2);
  }
  
  //render grid
  int x = x0;
  int y = y0;
  for(int r = 0; r < grid.length; r++)
  {
    for(int c = 0; c < grid[r].length; c++)
    {
      cBox = colors[r][c];
      fill(cBox.r, cBox.g, cBox.b);
      rect(x, y, 50, 50);
      x += 50;
    }
    x = x0;
    y += 50;
  }
  
  //render blocks
  if(pieces[0])
  {
    b1.render();
  }
  if(pieces[1])
  {
    b2.render();
  }
  if(pieces[2])
  {
    b3.render();
  }
}

public void mouseReleased()
{
  //snap on release
  if(b1.selected)
  {
    b1.dragOff();
    b1.snap = true;
  }
  else if(b2.selected)
  {
    b2.dragOff();
    b2.snap = true;
  }
  else if(b3.selected)
  {
    b3.dragOff();
    b3.snap = true;
  }
}

public void mainSnap(Block piece, int position)
{
  String snapOut = piece.snap();
  if(snapOut.substring(0,1).equals("s"))
  {
    //place block
    int cSnap = Integer.parseInt(snapOut.substring(1,2));
    int rSnap = Integer.parseInt(snapOut.substring(2,3));
    for(int i = 0; i < piece.shapeX.length; i++)
    {
      if(grid[rSnap + piece.shapeY[i]][cSnap + piece.shapeX[i]] != 0)
      {
        piece.valid = false;
        return;
      }
    }
    for(int i = 0; i < piece.shapeX.length; i++)
    {
      grid[rSnap + piece.shapeY[i]][cSnap + piece.shapeX[i]] = piece.c;
    }
    pieces[position] = false;
    if(pieces[0] == false && pieces[1] == false && pieces[2] == false)
    {
      reload();
    }
  }
  else if(!snapOut.equals("N/A"))
  {
    //only hover
    int rSnap = Integer.parseInt(snapOut.split(",")[1]);
    int cSnap = Integer.parseInt(snapOut.split(",")[0]);
    for(int i = 0; i < piece.shapeX.length; i++)
    {
      if(grid[rSnap + piece.shapeY[i]][cSnap + piece.shapeX[i]] != 0)
      {
        piece.hoverValid = false;
        return;
      }
    }
    for(int i = 0; i < piece.shapeX.length; i++)
    {
      colors[rSnap + piece.shapeY[i]][cSnap + piece.shapeX[i]] = search.getColor(-1);
    }
  }
}

public void reload()
{
  b1 = new Block("o", 0);
  b2 = new Block("l", 1);
  b3 = new Block("i", 2);
  
  pieces[0] = true;
  pieces[1] = true;
  pieces[2] = true;
}

public void lineClear()
{
}
