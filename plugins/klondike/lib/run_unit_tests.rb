class RunUnitTests < PMIPAction
  def run(event, context)
    result("Running ...")
    RunConfiguration.new(context).choose("Unit Tests").run("Run", event.presentation)
  end
end
