
# The structs that contain info about the font
module BMFont
  # Info about the font
  Info = Struct.new(
    :face,
    :size,
    :bold,
    :italic,
    :charset,
    :unicode,
    :stretchH,
    :smooth,
    :aa,
    :padding,
    :spacing,
    :outline
  )
  
  # Info common to all characters
  Common = Struct.new(
    :lineHeight,
    :base,
    :scaleW,
    :scaleH,
    :pages,
    :packed,
    :alphaChnl,
    :redChnl,
    :greenChnl,
    :blueChnl
  )
  
  # Info about the bitmap pages that contain the characters
  Page = Struct.new(
    :id,
    :file
  )
  
  # Info about individual characters
  Char = Struct.new(
    :id,
    :x,
    :y,
    :width,
    :height,
    :xoffset,
    :yoffset,
    :xadvance,
    :page
  )
end
