class RestartInvestor < PMIPAction
  def run(event, context)
    Run.read_action {
      Action.from_id('Stop').run(event.presentation)
      RunConfiguration.new.choose('GWT Investor Server (real services)').run('Run', event.presentation)
      result('done')
    }
  end
end