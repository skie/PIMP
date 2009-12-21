import com.intellij.ide.DataManager
import com.intellij.openapi.actionSystem.DataKeys
import com.intellij.openapi.fileEditor.FileEditorManager
import com.intellij.openapi.vcs.changes.ChangesUtil
import com.intellij.psi.PsiDocumentManager
import com.intellij.psi.PsiManager

class PMIPContext
  def project
    DataKeys::PROJECT.get_data(data_context)
  end

  def selected_psi_elements
    return project_tree_psi_elements if project_tree?
    return changes_tab_psi_elements if changes_tab?
    return virtual_file_psi_elements if has_virtual_files?
    return [editor_psi_element] if editor?
    []
  end

  def filepath_from_root(filename)
    filepath_for(root + "/" + filename)
  end

  def editor?
    DataKeys::EDITOR.get_data(data_context) != nil
  end

  def editor_filepath
    filepath_for(editor_psi_element.virtual_file.path)  
  end

  def editor_current_word
    selection_model = editor.selection_model
    selection_model.select_word_at_caret(false)
    word = selection_model.selected_text
    selection_model.remove_selection
    word
  end

  def root
    project.base_dir.path
  end

  def editor
#    isTrue(isEditor(), "context must be an editor", isEditor());
    FileEditorManager.get_instance(project).selected_text_editor
  end
  
  private

  #TODO: maybe whack this
  def filepath_for(filename)
    Filepath.new(filename)
  end

  def data_context
    DataManager.instance.data_context
  end

  def project_tree?
    DataKeys::PSI_ELEMENT_ARRAY.get_data(data_context) != nil
  end

  def changes_tab?
    DataKeys::CHANGES.get_data(data_context) != nil
  end

  def has_virtual_files?
    DataKeys::VIRTUAL_FILE_ARRAY.get_data(data_context) != nil
  end

  def project_tree_psi_elements
    DataKeys::PSI_ELEMENT_ARRAY.get_data(data_context)
  end

  def changes_tab_psi_elements
    DataKeys::CHANGES.get_data(data_context).collect{|f| ChangesUtil.get_file_path(f) }
  end

  def virtual_file_psi_elements
    DataKeys::VIRTUAL_FILE_ARRAY.get_data(data_context).collect{|vf| PsiManager.get_instance(project).find_file(vf) }
  end

  def editor_psi_element
    PsiDocumentManager.get_instance(project).get_psi_file(editor.document)
  end
end