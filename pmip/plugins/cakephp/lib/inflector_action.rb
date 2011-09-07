
class InflectorAction < PMIPAction

  def perform_action(word)
    word
  end

  def run(event, context) 
	Run.write_action {
	  selection_model = context.current_editor.getSelectionModel
	  if selection_model.has_selection
	    word = selection_model.get_selected_text
	  else
        selection_model.select_word_at_caret(false)
        word = selection_model.selected_text
	  end
	  # delete removed as erplace used in insert_ext instead
	  #context.current_editor.delete_selected_text
	  inflection = perform_action(word)
	  context.current_editor.insert_ext(inflection, true, true)
	  name = action_name + "d"
	  result("Word " + word.to_s + " " + name + " to " + inflection)
	}  
  end

end


class InflectorCamelizeAction < InflectorAction
  def action_name
    "camelize"
  end
  
  def perform_action(word)
    Inflector.camelize(word)
  end
end

class InflectorUnderscoreAction < InflectorAction
  def action_name
    "underscore"
  end

  def perform_action(word)
    Inflector.underscore(word)
  end
end
