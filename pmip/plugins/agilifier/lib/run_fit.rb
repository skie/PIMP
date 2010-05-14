class RunFit < PMIPAction
  def initialize(action, end_to_end)
    super(action + " Fit" + (end_to_end ? " End To End" : ""))
    @action = action
    @end_to_end = end_to_end
  end

  def run(event, context)
    selected_tests = Fit.new(context).selected_tests
    unless selected_tests.empty?
      result(selected_tests)
      Suite.new(context, "MySelectedWork.suite").create(selected_tests)
      RunConfiguration.new(context).choose(run_configuration_name).run(@action, event.presentation)
    end
  end

  private

  def run_configuration_name
    @end_to_end ? "My Selected End To End" : "My Selected Work"
  end
end
