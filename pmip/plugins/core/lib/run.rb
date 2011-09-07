import com.intellij.openapi.application.ApplicationManager
import com.intellij.openapi.command.CommandProcessor;

class RunnableBlock
  include java.lang.Runnable

  def initialize(block)
    @block = block
  end

  def run
    @block.call
  end
end

class Run
  def self.on_pooled_thread(&block)
    ApplicationManager.application.executeOnPooledThread(RunnableBlock.new(block))
  end

  def self.later(&block)
    ApplicationManager.application.invokeLater(RunnableBlock.new(block))
  end

  def self.read_action(&block)
    ApplicationManager.application.runReadAction(RunnableBlock.new(block))
  end

  def self.write_action(&block)
    ApplicationManager.application.runWriteAction(RunnableBlock.new(block))
  end

  def self.execute_command(project, &block)
    CommandProcessor.getInstance().executeCommand(project, RunnableBlock.new(block))
  end
end