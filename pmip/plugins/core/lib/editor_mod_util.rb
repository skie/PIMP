import com.intellij.openapi.editor.EditorModificationUtil

class EditorModiUtil


   def EditorModiUtil.insertStringAtCaret(editor, s)
     EditorModificationUtil.insertStringAtCaret(editor, s)
   end

   def EditorModiUtil.insertStringAtCaretExt(editor, s, toProcessOverwriteMode, toMoveCaret)
     EditorModificationUtil.insertStringAtCaret(editor, s, toProcessOverwriteMode, toMoveCaret)
   end

   def EditorModiUtil.delete_selected_text(editor)
     EditorModificationUtil.deleteSelectedText(editor)
   end

   def EditorModiUtil.paste_from_clipboard(editor)
      EditorModificationUtil.pasteFromClipboard(editor)
   end


end