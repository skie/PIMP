import com.intellij.openapi.fileEditor.FileDocumentManager
import com.intellij.openapi.vfs.VirtualFileManager

class Refresh
   def self.file_system(&block)
     FileDocumentManager.instance.save_all_documents
     VirtualFileManager.instance.refresh(true, RunnableBlock.new(block))
   end
end