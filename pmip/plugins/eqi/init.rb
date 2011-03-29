load 'lib/optimise_development_environment.rb'
load 'lib/rename_tests_to_project_convention.rb'

bind 'banana ENTER', RunIntellijAction.new('EditorToggleColumnMode', 'Column Mode')
bind 'banana F', RunIntellijAction.new('OpenInBrowser', 'Open in Browser')
bind 'alt shift A', RunIntellijAction.new('Annotate', "Toggle Annotate")
bind 'alt shift H', RunIntellijAction.new('Vcs.ShowTabbedFileHistory', "Show History")
bind 'banana LEFT', RunIntellijAction.new('ChangesView.Rollback', 'Revert changes')
bind 'banana RIGHT', RunIntellijAction.new('CheckinFiles', "Commit Changes")
bind 'banana C', RunIntellijAction.new('CompareClipboardWithSelection', "Compare With Clipboard")
bind 'banana PAGE_UP', RunIntellijAction.new('MembersPullUp', 'Pull Up')
bind 'banana PAGE_DOWN', RunIntellijAction.new('MemberPushDown', 'Push Down')
bind 'banana T', ExecuteConfiguration.new('EQI Trader (for local)', 'Run', 'Run Trader')
bind 'banana I', ExecuteConfiguration.new('Investor Server', 'Run', 'Run Investor')
bind 'banana D', RunAntTarget.new('db-recreate', 'Re-create Database')
bind 'alt shift E', OpenFileExternally.new
bind 'banana F6', RenameTestsToProjectConvention.new

bind_and_run OptimiseDevelopmentEnvironment.new