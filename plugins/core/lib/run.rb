class RunnableBlock
  include java.lang.Runnable

  def initialize(block)
    @block = block
  end

  def run
    @block.call
  end
end

import com.intellij.openapi.application.ApplicationManager 

class Run
  def self.later(&block)
    ApplicationManager.application.executeOnPooledThread(RunnableBlock.new(block))
  end

  def self.now(&block)
    ApplicationManager.application.runReadAction(RunnableBlock.new(block))
  end
end