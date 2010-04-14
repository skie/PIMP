load 'lib/action.rb'
load 'lib/binder.rb'
load 'lib/browser.rb'
load 'lib/context.rb'
load 'lib/dialogs.rb'
load 'lib/elements.rb'
load 'lib/filepath.rb'
load 'lib/files.rb'
load 'lib/find_in_files.rb'
load 'lib/find_result.rb'
load 'lib/mounter.rb'
load 'lib/navigator.rb'
load 'lib/refresh.rb'
load 'lib/run.rb'
load 'lib/run_configuration.rb'
load 'lib/servlet.rb'
load 'lib/status_bar.rb'
load 'lib/tracker.rb'

load 'lib/action/execute_command.rb'
load 'lib/action/execute_configuration.rb'
load 'lib/action/run_ant_target.rb'

PMIP_CORE_VERSION = '0.2.3'

#TODO: add check to ensure that host version is good enough
puts "- Version: #{PMIP_CORE_VERSION}"
