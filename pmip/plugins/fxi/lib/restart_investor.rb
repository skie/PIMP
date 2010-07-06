class RestartInvestor < PMIPAction
  def run(event, context)
    Run.read_action {
      Action.from_id('Stop').run(event.presentation)
      ExecuteConfiguration.new('GWT Investor Server (real services)', 'Run', 'Run Investor').run(event, context)
      result('done')
    }
  end
end