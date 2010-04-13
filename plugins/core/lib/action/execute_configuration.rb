class ExecuteConfiguration < PMIPAction

  def initialize(configuration, action = 'Run', name = "#{(action + configuration)}")
    super(name)
    @configuration = configuration
    @action = action
  end

  def run(event, context)
    result('Running ...')
    RunConfiguration.new(context).choose(@configuration).run(@action, event.presentation)
  end
end