module BMFont
  # Main font class
  class Font
    
    # Create font
    def initialize(fontname)
      filename = fontname
      
      @info = Info.new
      @common = Common.new
      @pages = []
      @page_bitmaps = []
      @chars = []
      
      parse_fnt_file(filename)
      load_font_bitmaps
    end
    
    # Height of each line
    def line_height
      return @common.lineHeight
    end
    
    # Draw the text at the specified x, y coordinates
    def draw_text(destination_bitmap, x, y, text)
      start_x = x
      start_y = y
      cursor_x = start_x
      cursor_y = start_y
      
      for i in 0...text.length
        # New line character
        if text[i].chr == "\n"
          cursor_x = 0
          cursor_y += @common.lineHeight
        end
        
        char = @chars[text[i]]
        
        # If there was no info about this character in the font file, skip it
        next if char == nil
        
        # Render the character
        x = cursor_x + char.xoffset
        y = cursor_y + char.yoffset
        
        src_bitmap = @page_bitmaps[char.page]
        
        src_rect = Rect.new(
          char.x,
          char.y,
          char.width,
          char.height
        )
        
        destination_bitmap.blt(x, y, src_bitmap, src_rect)
        
        cursor_x += char.xadvance
      end
    end
    
    # Parse the font file
    def parse_fnt_file(filename)
      fontFile = File.open(filename)
      
      fontFile.each_line { |line|
        
        entries = line.split(" ")
        
        case entries[0]
        # Info about the font
        when "info"
          for i in 1...entries.length
            key_value = entries[i].split("=")
            case key_value[0]
              when "size", "stretchH", "spacing", "outline"
                @info[key_value[0].to_sym] = key_value[1].to_i
              when "bold", "italic", "unicode", "smooth", "aa"
                @info[key_value[0].to_sym] = (key_value[1].to_i == 1)
            end
          end
          
        # Info common to all characters
        when "common"
          for i in 1...entries.length
            key_value = entries[i].split("=")
            case key_value[0]
              when "lineHeight", "base", "scaleW", "scaleH", "pages"
                @common[key_value[0].to_sym] = key_value[1].to_i
              when "packed"
                @common[key_value[0].to_sym] = (key_value[1].to_i == 1)
            end
          end
          
        # Info about the bitmap pages that contain the characters
        when "page"
          page = Page.new
          
          for i in 1...entries.length
            key_value = entries[i].split("=")
            case key_value[0]
              when "id"
                page[key_value[0].to_sym] = key_value[1].to_i
              when "file"
                page[key_value[0].to_sym] = key_value[1].tr("\"", "")
            end
          end
          
          @pages[page.id] = page
          
        # Info about individual characters
        when "char"
          char = Char.new
          
          for i in 1...entries.length
            key_value = entries[i].split("=")
            case key_value[0]
              when "id", "x", "y", "width", "height", "xoffset", "yoffset", "xadvance", "page"
                char[key_value[0].to_sym] = key_value[1].to_i
            end
          end
          
          @chars[char.id] = char
        end
      }
    end
    
    # Load the bitmaps for the font pages
    def load_font_bitmaps
      for page in @pages
        @page_bitmaps[page.id] = RPG::Cache.picture(page.file)
      end
    end
  end
end
