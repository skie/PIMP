load 'lib/goto_css.rb'
load 'lib/micro_plugins.rb'

load 'lib/restart_investor.rb'
load 'lib/view_chevron_tech.rb'
load 'lib/toggle_through_cases.rb'

context = PMIPContext.new


bind 'ctrl F11', RunAntTarget.new('gwt-compile-obfuscated', 'Compile GWT')
bind 'pear F11', RunAntTarget.new('deploy-gwt-css-and-images-from-intellij', 'Deploy CSS and Images')
bind 'banana I', RestartInvestor.new
bind 'alt shift S', GotoCss.new
bind 'alt shift R', RunAntTarget.new('produce-junit-report', 'Produce JUnit Report')
bind 'banana U', ToggleThroughCases.new
bind 'banana M', MicroPlugins.new
bind 'alt shift A', RunIntellijAction.new('Annotate', "Toggle Annotate")

log_file = context.filepath_from_root('logs/workbenchmessages.log')

bind 'banana COMMA', ViewChevronTech.new(ChevronConfig.response, log_file, 'Response Chevron Tech')
bind 'banana PERIOD', ViewChevronTech.new(ChevronConfig.request, log_file, 'Request Chevron Tech')

#TODO: a bit iffy in chrome ... seems to need manual intervention
bind 'banana P', ExecuteCommand.new('regedit /s useUBSProxySettings.reg', context.filepath_from_root('tools'), 'Restore Browser Proxy (beta)')
#TODO: a bit iffy ... because the window closes
bind 'banana X', ExecuteCommand.new('fx.bat', context.root, 'Run FX.bat (beta)')