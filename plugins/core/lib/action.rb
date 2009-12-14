import com.intellij.openapi.actionSystem.AnAction

class PMIPBaseAction < AnAction
  def initialize(name)
    super(name, name, nil)
    @name = name
  end

  def name
    "" == @name ? self.class.to_s : @name
  end
end

class PMIPAction < PMIPBaseAction
  def initialize(name = "")
    super(name)
  end

  def actionPerformed(event)
    reset_result
    context = PMIPContext.new
    StatusBar.new(context).set("Running #{name} ...")
    begin
      run(event, context)
      message = "#{name}: #{@result}"
      puts "- #{message}"
      StatusBar.new(context).set(message)
    rescue => e
      message = "Error: #{e.message}:\n#{e.backtrace.join("\n")}"
      puts message
      Dialogs.new.error("PMIP Plugin Error", "PMIP encounted an error while executing the action: " + name + "\n\n" + message + "\n\nPlease contact the plugin developer!")
      StatusBar.new(context).set(message)
    end
  end

  protected

  def result(result)
    @result = result.is_a?(Array) ? result.join(', ') : result.to_s
    @result
  end

  private

  def reset_result
    result("Nothing to do")
  end
end