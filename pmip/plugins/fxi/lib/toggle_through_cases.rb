class ToggleThroughCases < PMIPAction
  def run(event, context)
    Refresh.file_system_before_and_after {
      current_editor = context.current_editor
      selected_text = current_editor.selection
      constant_cased = selected_text.split(/\W+/).collect {|word| word.upcase}.join('_')

      filepath = context.editor_filepath
      file_contents = filepath.read

      file_contents[current_editor.selection_range]=constant_cased

      filepath.write(file_contents)

      current_editor.highlight_word
      result("changed: #{selected_text} to #{constant_cased}")
    }
  end
end