public class Color
{
  public int r, g, b;
  public String theme = "basic";
  public String[] themes = new String[]{
    "basic",
    "pink",
    //"energy"
  };
  
  public Color(int r, int g, int b)
  {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public Color getColor(int colorID)
  {
    //return color from integer
    if(theme.equals("basic"))
    {
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
        case -2:
          //background
          return new Color(54, 127, 245);
        default:
          //background blue
          return new Color(9, 54, 128);
      }
    }
    else if(theme.equals("pink"))
    {
      switch(colorID)
      {
        case 1:
          return new Color(255, 200, 221);
        case 2:
          return new Color(255, 200, 221);
        case 3:
          return new Color(255, 175, 204);
        case 4:
          return new Color(255, 175, 204);
        case 5:
          return new Color(255, 200, 221);
        case 6:
          return new Color(255, 175, 204);
        case -1:
          return new Color(205, 180, 219);
        case -2:
          return new Color(162, 210, 255);
        default:
          return new Color(189, 224, 254);
      }
    }
    else if(theme.equals("energy")) // https://coolors.co/palette/7400b8-6930c3-5e60ce-5390d9-4ea8de-48bfe3-56cfe1-64dfdf-72efdd-80ffdb
    {
      switch(colorID)
      {
        case 1:
          return new Color(255, 200, 221);
        case 2:
          return new Color(255, 200, 221);
        case 3:
          return new Color(255, 175, 204);
        case 4:
          return new Color(255, 175, 204);
        case 5:
          return new Color(255, 200, 221);
        case 6:
          return new Color(255, 175, 204);
        case -1:
          return new Color(205, 180, 219);
        case -2:
          return new Color(162, 210, 255);
        default:
          return new Color(189, 224, 254);
      }
    }
    return new Color(9, 54, 128);
  }
  
  public void newTheme()
  {
    theme = themes[(int)(Math.random() * themes.length)];
  }
}
