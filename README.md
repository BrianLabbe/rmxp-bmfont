# rmxp-bmfont

This is a BMFont renderer for RPG Maker XP. The BMFont format is created by AngelCode, check out AngelCode's [BMFont page](http://www.angelcode.com/products/bmfont/) for more details.

# Details
This is not for standalone Ruby, it is for use within RPG Maker XP, and relies on RGSS classes. (There are also no `require`s for the same reason, RPG Maker XP automatically combines all script entries).

To install, add the contents of the two files to script entries in RPG Maker XP. (eg. `BMFont::Structs` and `BMFont::Font`).

To use, simple create a font and call `BMFont::Font#draw_tex`:
```
bitmap = Bitmap.new(640, 480)

font = BMFont::Font.new("Fonts/fontname.fnt")

font.draw_text(bitmap, 0, 0, "Some text to draw!")
```

`BMFont::Font#draw_text` takes 4 arguments: The bitmap to render to, the x position to start rendering from, the y position to start rendering from, and the text to render.

# Creating a BMFont font
AngelCode's [BMFont page](http://www.angelcode.com/products/bmfont/) has a tool to generate BMFonts, and you can find details there. However, there are some specific considerations for making fonts to use with RPG Maker XP:
- Kerning pairs are not currently implemented by this script, so they will be ignored
- You need to export the image in a format that RPG Maker can understand. This means you should export in 32 bits, and you should export as .png. You should also export using the preset "White text with alpha" (you still have to pick a transparent color when importing into RMXP, click a spot where there are no letters to do so).
