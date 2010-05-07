import com.intellij.openapi.fileEditor.FileDocumentManager
import com.intellij.openapi.vfs.VirtualFileManager

class Refresh
   def self.file_system_after(&block)
     FileDocumentManager.instance.save_all_documents
     RunnableBlock.new(block).run
     VirtualFileManager.instance.refresh(true)
   end
end