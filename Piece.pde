public class Piece
{
  //piece type
  public String type;
  //all pieces
  public final String[] types = new String[]{
    "1",
    "H2",
    "V2",
    "HI3",
    "VI3",
    "UL3",
    "HL3",
    "VL3",
    "OL3",
    "S4"
  };
  
  //individual block coordinates
  public int[] shapeX;
  public int[] shapeY;
  
  //color
  public int c;
  //color search
  public Color search = new Color(0, 0, 0);
  
  //origin and position
  public int x0, y0;
  public int x, y;
  
  //size
  public int w, h;
  
  //mouse offset(drag)
  public int xDist, yDist;
  //dragging
  public boolean selected = false;
  
  //place piece this frame
  public boolean place = false;
  
  //piece at valid position(snap)
  public boolean valid = true;
  
  //reset piece this frame
  public boolean reset = false;
  
  //game over this frame
  public boolean over = false;
  
  public Piece(String type, int position)
  {
    setPiece(type, position);
  }
  
  public Piece(int[][] grid, int position)
  {
    //create piece randomly under the condition that it must be placeable
    
    //placeable pieces
    ArrayList<String> available = new ArrayList<>();
    //current piece to check
    Piece check;
    //copy all pieces into available
    for(String type : types)
    {
      available.add(type);
    }
    
    while(true)
    {
      //select random piece
      int n = (int)(Math.random() * available.size());
      check = new Piece(types[n], position);
      
      if(validate(grid, check)) //can be placed
      {
        break;
      }
      else if(available.size() == 1) //no more pieces to select
      {
        this.over = true;
        return;
      }
      
      //remove from placeables if it can't be placed
      available.remove(n);
    }
    
    String type = check.type;
    setPiece(type, position);
  } 
  
  public void render()
  {
    //disable stroke
    noStroke();
    
    //set color
    Color thisColor = search.getColor(c);
    fill(thisColor.r, thisColor.g, thisColor.b);
    
    //detect drag
    for(int i = 0; i < shapeX.length; i++)
    {
      if(
          (x < mouseX && mouseX < x + w * 50) &&
          (y < mouseY && mouseY < y + h * 50) &&
          (mousePressed)
      )
      {
        selected = true;
        //set offsets
        xDist = mouseX - x;
        yDist = mouseY - y;
      }
      if(selected)
      {
        //set position
        x = mouseX - xDist;
        y = mouseY - yDist;
      }
      
      //draw rectangle
      rect(x + 50 * shapeX[i], y + 50 * shapeY[i], 50, 50);
    }
  }
  
  public void dragOff()
  {
    //stop drag
    selected = false;
  }
  
  public String snap()
  {
    if(reset) //reset to dock
    {
      reset = false;
      x = x0;
      y = y0;
      return "";
    }
    
    int xSnap = (x - 100) / 50;
    int ySnap = (y - 100) / 50;
    
    if(place)
    {
      if(valid == false) //reset if invalid
      {
        valid = true;
        reset = true;
        return "";
      }
      
      if(ySnap < 0 || ySnap > 8 - h || xSnap < 0 || xSnap > 8 - w) //reset if out of bounds
      {
        reset = true;
        return "";
      }
      
      return "p" + xSnap + ySnap;
    }
    else
    {
      if(valid == false) //dont track if invalid
      {
        valid = true;
        return "";
      }
      
      if(ySnap < 0 || ySnap > 8 - h || xSnap < 0 || xSnap > 8 - w) //dont track if out of bounds
      {
        return "";
      }
      
      return "t" + xSnap + ySnap;
    }
  }
  
  public boolean validate(int[][] grid, Piece piece)
  {
    //check if piece can be placed
    for(int r = 0; r < grid.length; r++)
    {
      block:
      for(int c = 0; c < grid[r].length; c++)
      {
        for(int i = 0; i < piece.shapeX.length; i++)
        {
          if
          (
            (r + piece.shapeY[i] >= 8 || c + piece.shapeX[i] >= 8) || 
            (grid[r + piece.shapeY[i]][c + piece.shapeX[i]] != 0)
          )
          {
            continue block;
          }
        }
        //at least one piece can be placed
        return true;
      }
    }
    //no piece can be placed
    return false;
  }
  
  public void setPiece(String type, int position)
  {
    //initialize values based on type and position
    if(type.equals("1")) //1 blocks
    {
      this.shapeX = new int[]{0};
      this.shapeY = new int[]{0};
      this.c = 1; this.w = 1; this.h = 1;
    }
    else if(type.equals("H2")) //horizontal 2 blocks
    {
      this.shapeX = new int[]{0, 1};
      this.shapeY = new int[]{0, 0};
      this.c = 2; this.w = 2; this.h = 1;
    }
    else if(type.equals("V2")) //vertical 2 blocks
    {
      this.shapeX = new int[]{0, 0};
      this.shapeY = new int[]{0, 1};
      this.c = 3; this.w = 1; this.h = 2;
    }
    else if(type.equals("HI3")) //horizontal I-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 1, 2};
      this.shapeY = new int[]{0, 0, 0};
      this.c = 4; this.w = 3; this.h = 1;
    }
    else if(type.equals("VI3")) //vertical I-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 0, 0};
      this.shapeY = new int[]{0, 1, 2};
      this.c = 5; this.w = 1; this.h = 3;
    }
    else if(type.equals("UL3")) //upright L-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 0, 1};
      this.shapeY = new int[]{0, 1, 1};
      this.c = 6; this.w = 2; this.h = 2;
    }
    else if(type.equals("HL3")) //horizontally inverted L-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 1, 0};
      this.shapeY = new int[]{0, 0, 1};
      this.c = 1; this.w = 2; this.h = 2;
    }
    else if(type.equals("VL3")) //vertically inverted L-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 1, 1};
      this.shapeY = new int[]{1, 1, 0};
      this.c = 2; this.w = 2; this.h = 2;
    }
    else if(type.equals("OL3")) //origin inverted L-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 1, 1};
      this.shapeY = new int[]{0, 0, 1};
      this.c = 3; this.w = 2; this.h = 2;
    }
    else if(type.equals("S4")) //square 4 blocks
    {
      this.shapeX = new int[]{0, 0, 1, 1};
      this.shapeY = new int[]{0, 1, 1, 0};
      this.c = 4; this.w = 2; this.h = 2;
    }
    
    this.type = type;
    this.x0 = (200 - 50 * w) / 2 + position * 200;
    this.y0 = (200 - 50 * h) / 2 + 550;
    this.x = x0;
    this.y =y0;
  }
}
