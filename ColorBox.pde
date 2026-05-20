public class ColorBox
{
  public int r, g, b;
  
  public ColorBox(int r, int g, int b)
  {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public ColorBox getColor(int colorID)
  {
    switch(colorID)
    {
      case 0:
        //basic
        return new ColorBox(9, 54, 128);
      case 1:
        //yellow
        return new ColorBox(251, 211, 13);
      case 2:
        //red
        return new ColorBox(209, 61, 58);
      case 3:
        //purple
        return new ColorBox(148, 83, 228);
      case -1:
        return new ColorBox(255, 255, 255);
      default:
        return new ColorBox(9, 54, 128);
    }
  }
}
