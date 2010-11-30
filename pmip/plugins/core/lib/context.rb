import com.intellij.ide.DataManager
import com.intellij.openapi.actionSystem.DataKeys
import com.intellij.openapi.fileEditor.FileEditorManager
import com.intellij.openapi.project.ProjectManager
import com.intellij.openapi.vcs.changes.ChangesUtil
import com.intellij.psi.PsiDocumentManager
import com.intellij.psi.PsiManager

class PMIPContext
  def project
    project = DataKeys::PROJECT.get_data(data_context)
    return project unless project.nil?
    #TIP: the above seems to fail in intellij 9: fallback to ProjectManager
    return ProjectManager.instance.open_projects[0] if ProjectManager.instance.open_projects.size != 0
    raise "unable to get hold of the project"
  end

  def selected_psi_elements
    return project_tree_psi_elements if project_tree?
    return changes_tab_psi_elements if changes_tab?
    return virtual_file_psi_elements if has_virtual_files?
    return [editor_psi_element] if editor?
    []
  end

  def filepath_from_root(filename)
    Filepath.new(root + "/" + filename)
  end

  def editor_filepath
    Filepath.new(editor_psi_element.virtual_file.path)
  end

  def root
    project.base_dir.path
  end

  def plugin_root
    raise "plugin_root only available during plugin initialisation" if $plugin.nil?
    "#{root}/pmip/plugins/#{$plugin}"
  end

  def current_editor
    Editor.new(selected_text_editor)
  end

  private

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

  def editor?
    DataKeys::EDITOR.get_data(data_context) != nil
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

  def selected_text_editor
    FileEditorManager.get_instance(project).selected_text_editor
  end

  def editor_psi_element
    PsiDocumentManager.get_instance(project).get_psi_file(selected_text_editor.document)
  end
end