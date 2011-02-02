bind 'banana F', RunIntellijAction.new('CheckinFiles', "Commit File")
bind 'alt shift A', RunIntellijAction.new('Annotate', "Toggle Annotate")
bind 'alt shift H', RunIntellijAction.new('Vcs.ShowTabbedFileHistory', "Show History")

bind 'banana T', ExecuteConfiguration.new('EQI Trader (with fake services)')
bind 'banana I', ExecuteConfiguration.new('Investor Server')

bind 'banana D', RunAntTarget.new('db-recreate', 'Re-create Database')