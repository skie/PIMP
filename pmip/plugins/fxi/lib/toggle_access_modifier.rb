class ToggleAccessModifier < PMIPAction
  PUBLIC = 'public'
  PRIVATE = 'private'
  PROTECTED = 'protected'
  PACKAGE = '/*package*/'
  CLASS = 'class'
  INTERFACE = 'interface'

  def run(event, context)
    Refresh.file_system_before_and_after {
      line_number = context.current_editor.line_number
      filepath = context.editor_filepath
      lines = filepath.readlines

      current_line = lines[line_number]
      updated_line = toggle_modifier(current_line)

      if current_line != updated_line
        lines[line_number] = updated_line
        result("toggled line: '#{updated_line.strip}' in: #{filepath.filename}")
      else
        lines = lines.collect{|l| make_as_private_as_possible(l) }
        result("made everything as private as possible in: #{filepath.filename}")
      end
      filepath.writelines(lines)
    }
  end

  private

  def toggle_modifier(l)
    if class_or_interface?(l)
      #TIP: obviously won't work for inner classes .. if only we had an AST
      return l.sub(PUBLIC, PACKAGE) if public?(l)
      return l.sub(PACKAGE, PUBLIC) if package?(l)
    else
      return l.sub(PUBLIC, PRIVATE) if public?(l)
      return l.sub(PRIVATE, PACKAGE) if private?(l)
      return l.sub(PACKAGE, PROTECTED) if package?(l)
      return l.sub(PROTECTED, PUBLIC) if protected?(l)
    end
    l
  end

  def make_as_private_as_possible(l)
    if class_or_interface?(l)
      #TIP: obviously won't work for inner classes .. if only we had an AST
      return l.sub(PUBLIC, PACKAGE) if public?(l)
    else
      return l.sub(PUBLIC, PRIVATE) if public?(l)
      return l.sub(PACKAGE, PRIVATE) if package?(l)
      return l.sub(PROTECTED, PRIVATE) if protected?(l)
    end
    l
  end

  def public?(l); l =~ /\s*#{PUBLIC}\s(.*?)/; end
  def protected?(l); l =~ /\s*#{PROTECTED}\s/; end
  def package?(l); l =~ /\s*#{PACKAGE.gsub('*', '\*')}\s(.*?)/; end
  def private?(l); l =~ /\s*#{PRIVATE}\s/; end
  def class?(l); l =~ /\s#{CLASS}\s/; end
  def interface?(l); l =~ /\s#{INTERFACE}\s/; end
  def class_or_interface?(l); class?(l) || interface?(l); end
end