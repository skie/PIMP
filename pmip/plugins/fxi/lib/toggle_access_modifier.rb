class ToggleAccessModifier < PMIPAction
  PUBLIC = 'public'
  PRIVATE = 'private'
  PROTECTED = 'protected'
  PACKAGE = '/*package*/'

  def run(event, context)
    Refresh.file_system_before_and_after {
      line_number = context.editor_current_line_number
      filepath = context.editor_filepath
      lines = filepath.readlines
      current_line = lines[line_number]
      updated_line = update_line(current_line)
      if current_line != updated_line
        lines[line_number] = updated_line
        filepath.writelines(lines)
        result("#{updated_line.strip}")
      end
    }
  end

  private

  def update_line(line)
    case line
      when /\s*#{PUBLIC}\s/
        return line.sub(PUBLIC, PRIVATE)
      when /\s*#{PRIVATE}\s/
        return line.sub(PRIVATE, PACKAGE)
      when /\s*#{PACKAGE.gsub('*', '\*')}\s/
        return line.sub(PACKAGE, PROTECTED)
      when /\s*#{PROTECTED}\s/
        return line.sub(PROTECTED, PUBLIC)
    end
    line
  end
end