public class Color
{
  public int r, g, b;
  public String theme = "basic";
  public String[] themes = new String[]{
    "pink",
    "energy",
    "green",
    "summer",
    "color",
    "night",
    "cherry",
    "earth"
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
          //hover
          return new Color(255, 255, 255);
        case -2:
          //background
          return new Color(54, 127, 245);
        default:
          //grid
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
    else if(theme.equals("energy"))
    {
      switch(colorID)
      {
        case 1:
          return new Color(128, 255, 219);
        case 2:
          return new Color(100, 223, 223);
        case 3:
          return new Color(72, 191, 227);
        case 4:
          return new Color(128, 255, 219);
        case 5:
          return new Color(100, 223, 223);
        case 6:
          return new Color(72, 191, 227);
        case -1:
          return new Color(116, 0, 184);
        case -2:
          return new Color(78, 168, 222);
        default:
          return new Color(94, 96, 206);
      }
    }
    else if(theme.equals("green"))
    {
      switch(colorID)
      {
        case 1:
          return new Color(216, 243, 220);
        case 2:
          return new Color(183, 228, 199);
        case 3:
          return new Color(149, 213, 178);
        case 4:
          return new Color(116, 198, 157);
        case 5:
          return new Color(82, 183, 136);
        case 6:
          return new Color(64, 145, 108);
        case -1:
          return new Color(45, 106, 79);
        case -2:
          return new Color(8, 28, 21);
        default:
          return new Color(27, 67, 50);
      }
    }
    else if(theme.equals("summer"))
    {
      switch(colorID)
      {
        case 1:
          return new Color(242, 132, 130);
        case 2:
          return new Color(245, 202, 195);
        case 3:
          return new Color(246, 189, 96);
        case 4:
          return new Color(242, 132, 130);
        case 5:
          return new Color(245, 202, 195);
        case 6:
          return new Color(246, 189, 96);
        case -1:
          return new Color(132, 165, 157);
        case -2:
          return new Color(132, 165, 157);
        default:
          return new Color(247, 237, 226);
      }
    }
    else if(theme.equals("color"))
    {
      switch(colorID)
      {
        case 1:
          return new Color(255, 153, 200);
        case 2:
          return new Color(252, 246, 189);
        case 3:
          return new Color(208, 244, 222);
        case 4:
          return new Color(169, 222, 249);
        case 5:
          return new Color(228, 193, 249);
        case 6:
          return new Color(255, 163, 255);
        case -1:
          return new Color(242, 242, 242);
        case -2:
          return new Color(242, 242, 242);
        default:
          return new Color(255, 255, 255);
      }
    }
    else if(theme.equals("night"))
    {
      switch(colorID)
      {
        case 1:
          return new Color(151, 223, 252);
        case 2:
          return new Color(133, 138, 227);
        case 3:
          return new Color(97, 61, 193);
        case 4:
          return new Color(78, 20, 140);
        case 5:
          return new Color(88, 178, 214);
        case 6:
          return new Color(42, 149, 191);
        case -1:
          return new Color(22, 10, 26);
        case -2:
          return new Color(22, 10, 26);
        default:
          return new Color(110, 101, 120);
      }
    }
    else if(theme.equals("cherry"))
    {
      switch(colorID)
      {
        case 1:
          return new Color(201, 24, 74);
        case 2:
          return new Color(255, 77, 109);
        case 3:
          return new Color(255, 117, 143);
        case 4:
          return new Color(255, 143, 163);
        case 5:
          return new Color(255, 179, 193);
        case 6:
          return new Color(255, 204, 213);
        case -1:
          return new Color(255, 240, 243);
        case -2:
          return new Color(89, 13, 34);
        default:
          return new Color(164, 19, 60);
      }
    }
    else if(theme.equals("earth"))
    {
      switch(colorID)
      {
        case 1:
          return new Color(240, 234, 210);
        case 2:
          return new Color(221, 229, 182);
        case 3:
          return new Color(173, 193, 120);
        case 4:
          return new Color(240, 234, 210);
        case 5:
          return new Color(221, 229, 182);
        case 6:
          return new Color(173, 193, 120);
        case -1:
          return new Color(108, 88, 76);
        case -2:
          return new Color(108, 88, 76);
        default:
          return new Color(169, 132, 103);
      }
    }
    return new Color(9, 54, 128);
  }
  
  public void newTheme()
  {
    String prevTheme = theme;
    while(prevTheme.equals(theme))
    {
      theme = themes[(int)(Math.random() * themes.length)];
    }
  }
}
