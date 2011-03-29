import com.intellij.refactoring.rename.RenameProcessor
import com.intellij.psi.PsiDocumentManager
import com.intellij.openapi.fileEditor.FileDocumentManager

class Refactor
  def initialize(context = PMIPContext.new)
    @context = context
  end

  def rename(element, new_name, search_in_comments = false, search_text_occurrences = false)
    RenameProcessor.new(@context.project, element, new_name, search_in_comments, search_text_occurrences).run
    self
  end

  def commit
    PsiDocumentManager.getInstance(@context.project).commit_all_documents
    FileDocumentManager.instance.save_all_documents
  end
end