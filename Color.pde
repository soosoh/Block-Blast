public class Color
{
  public int r, g, b;
  
  public Color(int r, int g, int b)
  {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public Color getColor(int colorID)
  {
    //return color from integer
    switch(colorID)
    {
      case 1:
        //yellow
        return new Color(251, 211, 13);
      case 2:
        //red
        return new Color(209, 61, 58);
      case 3:
        //purple
        return new Color(148, 83, 228);
      case 4:
        //green
        return new Color(41, 208, 49);
      case 5:
        //lightblue
        return new Color(36, 202, 246);
      case 6:
        //orange
        return new Color(231, 162, 43);
      case -1:
        //white(hover)
        return new Color(255, 255, 255);
      default:
        //background blue
        return new Color(9, 54, 128);
    }
  }
}
