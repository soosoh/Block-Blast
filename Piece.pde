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
    "S4",
    "UT4",
    "RT4",
    "DT4",
    "LT4",
    "D3",
    "ID3",
    "S9",
    "UL4",
    "RL4",
    "DL4",
    "LL4",
    "UJ4",
    "RJ4",
    "DJ4",
    "LJ4",
    "US4",
    "RS4",
    "UZ4",
    "RZ4",
    "D2",
    "ID2",
    "P5",
    "UR6",
    "RR6",
    "B5",
    "UC5",
    "RC5",
    "DC5",
    "LC5"
  };
  
  //individual block coordinates
  public int[] shapeX;
  public int[] shapeY;
  
  //color
  public int c;
  
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
  
  public boolean render(int drag, int position, Color search)
  {
    //set color
    Color thisColor = search.getColor(c);
    fill(thisColor.r, thisColor.g, thisColor.b);
    
    //detect drag
    for(int i = 0; i < shapeX.length; i++)
    {
      if(selected)
      {
        //set position
        x = mouseX - xDist;
        y = mouseY - yDist;
      }
      
      //draw rectangle
      rect(x + 50 * shapeX[i], y + 50 * shapeY[i], 50, 50);
    }
    
    //return false if another piece is being dragged
    if((drag == -1 || drag == position) && !selected)
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
        return true;
      }
    }
    return false;
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
      place = false;
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
    }
    else if(type.equals("H2")) //horizontal 2 blocks
    {
      this.shapeX = new int[]{0, 1};
      this.shapeY = new int[]{0, 0};
    }
    else if(type.equals("V2")) //vertical 2 blocks
    {
      this.shapeX = new int[]{0, 0};
      this.shapeY = new int[]{0, 1};
    }
    else if(type.equals("HI3")) //horizontal I-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 1, 2};
      this.shapeY = new int[]{0, 0, 0};
    }
    else if(type.equals("VI3")) //vertical I-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 0, 0};
      this.shapeY = new int[]{0, 1, 2};
    }
    else if(type.equals("UL3")) //upright L-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 0, 1};
      this.shapeY = new int[]{0, 1, 1};
    }
    else if(type.equals("HL3")) //horizontally inverted L-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 1, 0};
      this.shapeY = new int[]{0, 0, 1};
    }
    else if(type.equals("VL3")) //vertically inverted L-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 1, 1};
      this.shapeY = new int[]{1, 1, 0};

    }
    else if(type.equals("OL3")) //origin inverted L-shaped 3 blocks
    {
      this.shapeX = new int[]{0, 1, 1};
      this.shapeY = new int[]{0, 0, 1};
    }
    else if(type.equals("S4")) //square 4 blocks
    {
      this.shapeX = new int[]{0, 0, 1, 1};
      this.shapeY = new int[]{0, 1, 1, 0};
    }
    else if(type.equals("UT4")) //up T-shaped 4 blocks
    {
      this.shapeX = new int[]{1, 0, 1, 2};
      this.shapeY = new int[]{0, 1, 1, 1};
    }
    else if(type.equals("RT4")) //right T-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 0, 1, 0};
      this.shapeY = new int[]{0, 1, 1, 2};
    }
    else if(type.equals("DT4")) //down T-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 1, 2, 1};
      this.shapeY = new int[]{0, 0, 0, 1};
    }
    else if(type.equals("LT4")) //left T-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 1, 1, 1};
      this.shapeY = new int[]{1, 0, 1, 2};
    }
    else if(type.equals("D3")) //diagonal 3 blocks
    {
      this.shapeX = new int[]{0, 1, 2};
      this.shapeY = new int[]{0, 1, 2};
    }
    else if(type.equals("ID3")) //inverted diagonal 3 blocks
    {
      this.shapeX = new int[]{2, 1, 0};
      this.shapeY = new int[]{0, 1, 2};
    }
    else if(type.equals("S9")) //square 9 blocks
    {
      this.shapeX = new int[]{0,1,2,0,1,2,0,1,2};
      this.shapeY = new int[]{0,0,0,1,1,1,2,2,2};
    }
    else if(type.equals("UL4")) //up L-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 0, 0, 1};
      this.shapeY = new int[]{0, 1, 2, 2};
    }
    else if(type.equals("RL4")) //right L-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 0, 1, 2};
      this.shapeY = new int[]{1, 0, 0, 0};
    }
    else if(type.equals("DL4")) //down L-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 1, 1, 1};
      this.shapeY = new int[]{0, 0, 1, 2};
    }
    else if(type.equals("LL4")) //left L-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 1, 2, 2};
      this.shapeY = new int[]{1, 1, 1, 0};
    }
    else if(type.equals("J4")) //J-shaped 4 blocks
    {
      this.shapeX = new int[]{2, 2, 1, 0};
      this.shapeY = new int[]{0, 1, 2, 1};
    }
    else if(type.equals("UJ4")) //up J-shaped 4 blocks
    {
      this.shapeX = new int[]{1, 1, 1, 0};
      this.shapeY = new int[]{0, 1, 2, 2};
    }
    else if(type.equals("RJ4")) //right J-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 0, 1, 2};
      this.shapeY = new int[]{0, 1, 1, 1};
    }
    else if(type.equals("DJ4")) //down J-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 1, 0, 0};
      this.shapeY = new int[]{0, 0, 1, 2};
    }
    else if(type.equals("LJ4")) //left J-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 1, 2, 2};
      this.shapeY = new int[]{0, 0, 0, 1};
    }
    else if(type.equals("US4")) //upright S-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 1, 1, 2};
      this.shapeY = new int[]{1, 1, 0, 0};
    }
    else if(type.equals("RS4")) //rotated S-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 0, 1, 1};
      this.shapeY = new int[]{0, 1, 1, 2};
    }
    else if(type.equals("UZ4")) //upright Z-shaped 4 blocks
    {
      this.shapeX = new int[]{0, 1, 1, 2};
      this.shapeY = new int[]{0, 0, 1, 1};
    }
    else if(type.equals("RZ4")) //rotated Z-shaped 4 blocks
    {
      this.shapeX = new int[]{1, 1, 0, 0};
      this.shapeY = new int[]{0, 1, 1, 2};
    }
    else if(type.equals("D2")) //diagonal 2 blocks
    {
      this.shapeX = new int[]{0, 1};
      this.shapeY = new int[]{0, 1};
    }
    else if(type.equals("ID2")) //diagonal 2 blocks
    {
      this.shapeX = new int[]{1, 0};
      this.shapeY = new int[]{0, 1};
    }
    else if(type.equals("P5")) //plus 5 blocks
    {
      this.shapeX = new int[]{0, 1, 1, 1, 2};
      this.shapeY = new int[]{1, 0, 1, 2, 1};
    }
    else if(type.equals("UR6")) //upright rectangular 6 blocks
    {
      this.shapeX = new int[]{0, 0, 0, 1, 1, 1};
      this.shapeY = new int[]{0, 1, 2, 0, 1, 2};
    }
    else if(type.equals("RR6")) //rotated rectangular 6 blocks
    {
      this.shapeX = new int[]{0, 1, 2, 0, 1, 2};
      this.shapeY = new int[]{0, 0, 0, 1, 1, 1};
    }
    else if(type.equals("B5")) //B-shaped 5 blocks
    {
      this.shapeX = new int[]{0,0,0,1,1};
      this.shapeY = new int[]{0,1,2,2,1};
    }
    else if(type.equals("UC5")) //up corner 5 blocks
    {
      this.shapeX = new int[]{0, 0, 0, 1, 2};
      this.shapeY = new int[]{0, 1, 2, 0, 0};
    }
    else if(type.equals("RC5")) //right corner 5 blocks
    {
      this.shapeX = new int[]{0, 1, 2, 2, 2};
      this.shapeY = new int[]{0, 0, 0, 1, 2};
    }
    else if(type.equals("DC5")) //down corner 5 blocks
    {
      this.shapeX = new int[]{2, 2, 2, 1, 0};
      this.shapeY = new int[]{0, 1, 2, 2, 2};
    }
    else if(type.equals("LC5")) //left corner 5 blocks
    {
      this.shapeX = new int[]{0, 0, 0, 1, 2};
      this.shapeY = new int[]{0, 1, 2, 2, 2};
    }
    else if(type.equals("")) //
    {
      this.shapeX = new int[]{};
      this.shapeY = new int[]{};
    }
    
    int wMax = 0;
    for(int xCoor : shapeX)
    {
      if(xCoor > wMax)
      {
        wMax = xCoor;
      }
    }
    this.w = wMax + 1;
    int yMax = 0;
    for(int yCoor : shapeY)
    {
       if(yCoor > yMax)
       {
         yMax = yCoor;
       }
    }
    this.h = yMax + 1;
    
    this.type = type;
    this.x0 = (200 - 50 * w) / 2 + position * 200;
    this.y0 = (200 - 50 * h) / 2 + 550;
    this.x = x0;
    this.y = y0;
    this.c = (int)(Math.random() * 6) + 1;
  }
}
