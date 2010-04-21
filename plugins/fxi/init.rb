load 'lib/goto_css.rb'
load 'lib/view_unit_test_results.rb'

context = PMIPContext.new

bind 'ctrl F11', RunAntTarget.new('gwtCompile-src/java', 'Compile GWT')
bind 'ctrl shift F11', RunAntTarget.new('deploy-gwt-css-and-images-from-intellij', 'Deploy CSS and Images')
bind 'banana I', ExecuteConfiguration.new('GWT Investor Server (real services)', 'Run', 'Run Investor' )
bind 'banana X', ExecuteCommand.new('fx.bat', context.root, 'Run FX.bat')
bind 'alt shift S', GotoCss.new

#TODO: package up ant/junit report
port = 9319
results = context.root + '/build/results/'
mount '/NavigateTo', NavigateTo
mount '/alltests-fails.html', UnitTestFailures, {:Path=> results, :Port => port}
mount '/', WEBrick::HTTPServlet::FileHandler, results
#TODO: should be context.plugin_root
mount '/assets', WEBrick::HTTPServlet::FileHandler, context.root + '/pmip/plugins/fxi/assets'
server port
bind 'banana R', OpenURL.new("http://localhost:#{port}", 'View Unit Test Results')

#TODO: a bit iffy in chrome ... seems to need a restart
#bind 'banana P', ExecuteCommand.new('regedit /s useUBSProxySettings.reg', context.filepath_from_root('tools'), 'Restore Browser Proxy')