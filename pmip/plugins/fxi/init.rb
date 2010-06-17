load 'lib/goto_css.rb'
load 'lib/static_import_type.rb'
load 'lib/toggle_access_modifier.rb'
load 'lib/view_chevron_tech.rb'
load 'lib/view_test_results.rb'
context = PMIPContext.new
port = 9319

ViewTestResults.start context, port

bind 'ctrl F11', RunAntTarget.new('gwt-compile-obfuscated', 'Compile GWT')
bind 'ctrl shift F11', RunAntTarget.new('deploy-gwt-css-and-images-from-intellij', 'Deploy CSS and Images')
bind 'banana I', ExecuteConfiguration.new('GWT Investor Server (real services)', 'Run', 'Run Investor' )
bind 'alt shift S', GotoCss.new
bind 'banana R', OpenURL.new("http://localhost:#{port}", 'View Test Results')
bind 'alt shift R', RunAntTarget.new('produce-junit-report', 'Produce JUnit Report')
bind 'banana 8', StaticImportType.new({'Assert' => 'org.junit.Assert'})
bind 'banana A', ToggleAccessModifier.new

log_file = context.filepath_from_root('logs/workbenchmessages.log')

bind 'banana COMMA', ViewChevronTech.new(ChevronConfig.response, log_file, 'Response Chevron Tech')
bind 'banana PERIOD', ViewChevronTech.new(ChevronConfig.request, log_file, 'Request Chevron Tech')

#TODO: a bit iffy in chrome ... seems to need manual intervention
bind 'banana P', ExecuteCommand.new('regedit /s useUBSProxySettings.reg', context.filepath_from_root('tools'), 'Restore Browser Proxy (beta)')
bind 'banana X', ExecuteCommand.new('fx.bat', context.root, 'Run FX.bat (beta)')