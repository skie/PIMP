import com.intellij.execution.RunManager
import com.intellij.openapi.actionSystem.AnActionEvent

class RunConfiguration
  def initialize(context)
    @context = context
  end

  def choose(name)
    runner_manager = RunManager.get_instance(@context.project)
    run_configurations = runner_manager.all_configurations().select{|c| name == c.name }

    if run_configurations.size != 1
      raise "Configuration error, expected to find 1 run configuration called: " + name + ", but found #{run_configurations.size}"
    end

    #TODO: should be .first
    runner_manager.set_selected_configuration(runner_manager.get_settings(run_configurations.first))
    self
  end

  #TODO: should probably have run() and debug() methods
  def run(action, presentation)
    Run.read_action { ActionManager.instance.get_action(action).action_performed(AnActionEvent.new(nil, DataManager.instance.data_context, "", presentation, ActionManager.instance, 0)) }
  end
end