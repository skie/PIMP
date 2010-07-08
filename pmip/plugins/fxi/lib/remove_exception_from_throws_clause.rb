class RemoveExceptionFromThrowsClause < PMIPAction
  def run(event, context)
    Refresh.file_system_before_and_after {
      exception = context.current_editor.word
      filepath = context.editor_filepath

      lines = filepath.readlines
      lines = lines.collect{|l| remove_exceptions_from_throws_clause(l, exception) }

      filepath.writelines(lines)
      result("removed #{exception} from all throws clauses in: #{filepath.filename}")
    }
  end

  private

  def remove_exceptions_from_throws_clause(line, exception)
    return mangle(exception, $1, $3, true) if line =~ /(.*)(throws)( .*?)\{/
    return mangle(exception, $1, $3, false) if line =~ /(.*)(throws)( .*)/
    line
  end

  def mangle(exception, method, clause, has_brace)
    exceptions = remove_exception(exception, clause)
    throws = exceptions.empty? ? '' : 'throws '
    brace = has_brace ? (exceptions.empty? ? '{' : ' {') : ''
    "#{method}#{throws}#{exceptions.join(', ')}#{brace}"
  end

  def remove_exception(exception, clause)
    clause.strip.split(',').collect{|b| b.gsub(' ', '') }.select{|b| b != exception }
  end
end