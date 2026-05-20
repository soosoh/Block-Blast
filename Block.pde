public class Block
{
  public String type;
  public int[] shapeX;
  public int[] shapeY;
  public int c;
  public int x, y;
  public int x0, y0;
  public int w, h;
  public int xDist, yDist;
  public boolean selected;
  public boolean snap = false;
  public ColorBox search = new ColorBox(0, 0, 0);
  
  public Block(String type, int position)
  {
    if(type.equals("l"))
    {
      this.shapeX = new int[]{0, 0, 1};
      this.shapeY = new int[]{0, 1, 1};
      this.c = 1;
      this.w = 2;
      this.h = 2;
    }
    else if(type.equals("o"))
    {
      this.shapeX = new int[]{0, 0, 1, 1};
      this.shapeY = new int[]{0, 1, 1, 0};
      this.c = 2;
      this.w = 2;
      this.h = 2;
    }
    else if(type.equals("i"))
    {
      this.shapeX = new int[]{0, 1, 2};
      this.shapeY = new int[]{0, 0, 0};
      this.c = 3;
      this.w = 3;
      this.h = 1;
    }
    this.type = type;
    this.x = (200 - 50 * w) / 2 + position * 200;
    this.y = (200 - 50 * h) / 2 + 550;
    this.x0 = x;
    this.y0 =y;
    //TODO: add auto centering
  }
  
  //add new constructor for randomized and smart block generation
  
  public void render()
  {
    noStroke();
    ColorBox cBox = search.getColor(c);
    fill(cBox.r, cBox.g, cBox.b);
    
    for(int i = 0; i < shapeX.length; i++)
    {
      if(x < mouseX && mouseX < x + w * 50 && y < mouseY && mouseY < y + h * 50 && mousePressed)
      {
        selected = true;
        xDist = mouseX -x ;
        yDist = mouseY - y;
      }
      if(selected)
      {
        x = mouseX - xDist;
        y = mouseY - yDist;
      }
      
      rect(x + 50 * shapeX[i], y + 50 * shapeY[i], 50, 50);
    }
  }
  
  public void dragOff()
  {
    selected = false;
  }
  
  public String snap()
  {
    int xSnap = (x - 100) / 50;
    int ySnap = (y - 100) / 50;
    if(snap)
    {
      this.snap = false;
      if(ySnap < 0 || ySnap > 8 - h || xSnap < 0 || xSnap > 8 - w)
      {
        x= x0;
        y = y0;
        return "N/A";
      }
      else
      {
        return "s" + xSnap + ySnap;
      }
    }
    if(ySnap < 0 || ySnap > 8 - h || xSnap < 0 || xSnap > 8 - w)
    {
      return "N/A";
    }
    else
    {
      return (xSnap + "," + ySnap);
    }
  }
}
