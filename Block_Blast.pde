/*
BLOCK BLAST in PROCESSING
By Hangyul Park, Rithvik Chamarthi
*/

//initialize grid starting point
final int x0 = 100;
final int y0 = 100;

//initialize grid
int[][] grid = new int[8][8];

//initialize color assignment container
Color[][] colors = new Color[8][8];
//color search
Color search = new Color(0, 0, 0);

//initialize piece container
Piece[] pieces = new Piece[3];

//initialize drag switch
int drag = -1;

//initialize score
int score = 0;
//initialize combo
int combo = 1;

//states game over when grid rendering is complete
boolean over = false;

public void setup()
{
  size(600, 800);
  reload();
  noStroke();
}

public void draw()
{
  //fill background
  background(54, 127, 245);
  assignColors();
  //TODO: Scheck for pieces to be cleared and make an hover effect
  //TODO: make effects
  snapPieces();
  renderGrid();
  renderPieces();
  renderScore();
  if(over)
  {
    gameOver();
  }
}

public void mouseReleased()
{
  //snap and disable drag on release
  for(int i = 0; i < pieces.length; i++)
  {
    if(pieces[i] != null && pieces[i].selected)
    {
      pieces[i].dragOff();
      pieces[i].place = true;
      break;
    }
  }
  
  drag = -1;
}

public void assignColors()
{
  //color assignment
  for(int r = 0; r < colors.length; r++)
  {
    for(int c = 0; c < colors[r].length; c++)
    {
      colors[r][c] = search.getColor(grid[r][c]);
    }
  }
}

public void snapPieces()
{
  //snap
  for(int i = 0; i < pieces.length; i++)
  {
    if(pieces[i] != null)
    {
      snap(pieces[i], i);
    }
  }
}

public void snap(Piece piece, int position)
{
  //retrieve snap output
  String snap = piece.snap();
  
  if(snap.equals("")) //no interaction
  {
    return;
  }
  
  int xSnap = Integer.parseInt(snap.substring(1,2));
  int ySnap = Integer.parseInt(snap.substring(2,3));
  
  //placing validation
  for(int i = 0; i < piece.shapeX.length; i++)
  {
    if(grid[ySnap + piece.shapeY[i]][xSnap + piece.shapeX[i]] != 0)
    {
      piece.valid = false;
      return;
    }
  }
  
  if(snap.substring(0,1).equals("p")) //place piece
  {  
    //update grid
    for(int i = 0; i < piece.shapeX.length; i++)
    {
      grid[ySnap + piece.shapeY[i]][xSnap + piece.shapeX[i]] = piece.c;
    }
    
    //update score
    score += piece.shapeX.length * 10;
    
    //delete piece
    pieces[position] = null;
    
    //clear lines
    clearLines();
    
    //reload if there are no pieces left
    boolean reload = true;
    for(int i = 0; i < pieces.length; i++)
    {
      if(pieces[i] != null)
      {
        reload = false;
      }
    }
    if(reload)
    {
      reload();
    }
    
    //check for game over
    over = true;
    for(int i = 0; i < pieces.length; i++)
    {
       if(pieces[i] != null && piece.validate(grid, pieces[i]))
       {
         over = false;
       }
    }
  }
  else if(snap.substring(0,1).equals("t")) //track piece
  {
    //color assignment
    for(int i = 0; i < piece.shapeX.length; i++)
    {
      colors[ySnap + piece.shapeY[i]][xSnap + piece.shapeX[i]] = search.getColor(-1);
    }
  }
}

public void reload()
{
  //reload pieces
  for(int i = 0; i < pieces.length; i++)
  {
    //TODO: update fakeGrid so all pieces can be put
    //TODO: then account for instances where space can be made by removing lines(ask mr rizzi)
    pieces[i] = new Piece(grid, i);
    if(pieces[i].over)
    {
      gameOver();
    }
  }
}

public void clearLines()
{
  //clear lines unformly filled
  ArrayList<Integer> clearRows = new ArrayList<Integer>();
  ArrayList<Integer> clearCols = new ArrayList<Integer>();
  
  //check rows
  for(int r = 0; r < grid.length; r++)
  {
    boolean filled = true;
    for(int c = 0; c < grid.length; c++)
    {
      if(grid[r][c] == 0)
      {
        filled = false;
      }
    }
    if(filled)
    {
      clearRows.add(r);
    }
  }
  
  //check columns
  for(int c = 0; c < grid[0].length; c++)
  {
    boolean filled = true;
    for(int r = 0; r < grid.length; r++)
    {
      if(grid[r][c] == 0)
      {
        filled = false;
      }
    }
    if(filled)
    {
      clearCols.add(c);
    }
  }
  
  //update rows
  for(int r = 0; r < grid.length; r++)
  {
    if(clearRows.contains(r))
    {
      for(int c = 0; c < grid.length; c++)
      {
        grid[r][c] = 0;
      }
    }
  }
  
  //update columns
  for(int c = 0; c < grid[0].length; c++)
  {
    if(clearCols.contains(c))
    {
      for(int r = 0; r < grid.length; r++)
      {
        grid[r][c] = 0;
      }
    }
  }
  
  //combo logic
  if(clearRows.size() + clearCols.size() > 0)
  {
    combo++;
  }
  else
  {
    combo = 1;
  }
  
  //update score
  score += combo * 100 * (clearRows.size() + clearCols.size());
}

public void renderScore()
{
  //set text color
  fill(9, 54, 128);
  
  //render score
  textSize(80);
  textAlign(CENTER);
  text(score, 300, 70);
  
  //render combo
  textSize(30);
  textAlign(LEFT);
  text("x" + combo, 470, 70);
  /*
  if (60<=score&&score<=68 )
  {
    textSize(100);
    textAlign(CENTER);
    text( 67676767, 300,100);
  }
  */
}

public void renderPieces()
{
  //render pieces
  for(int i = 0; i < pieces.length; i++)
  {
    if(pieces[i] != null)
    {
      if(pieces[i].render(drag, i))
      {
        drag = i;
      }
    }
  }
}

public void renderGrid()
{
  //render grid
  int x = x0;
  int y = y0;
  for(int r = 0; r < grid.length; r++)
  {
    for(int c = 0; c < grid[r].length; c++)
    {
      Color thisColor = colors[r][c];
      fill(thisColor.r, thisColor.g, thisColor.b);
      rect(x, y, 50, 50);
      x += 50;
    }
    x = x0;
    y += 50;
  }
}

public void gameOver()
{
  background(54, 127, 245);
  renderGrid();
  renderScore();
  
  //game over text
  textSize(80);
  textAlign(CENTER);
  text("GAME OVER", 300, 670);
  
  noLoop();
}
