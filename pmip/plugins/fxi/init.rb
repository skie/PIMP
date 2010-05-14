load 'lib/find_flaky_tests.rb'
load 'lib/goto_css.rb'
load 'lib/toggle_chevron_tech.rb'
load 'lib/view_test_results.rb'

context = PMIPContext.new
port = 9319

ViewTestResults.start context, port

bind 'ctrl F11', RunAntTarget.new('gwtCompile-src/java', 'Compile GWT')
bind 'ctrl shift F11', RunAntTarget.new('deploy-gwt-css-and-images-from-intellij', 'Deploy CSS and Images')
bind 'banana I', ExecuteConfiguration.new('GWT Investor Server (real services)', 'Run', 'Run Investor' )
bind 'banana X', ExecuteCommand.new('fx.bat', context.root, 'Run FX.bat')
bind 'alt shift S', GotoCss.new
bind 'banana R', OpenURL.new("http://localhost:#{port}", 'View Test Results')
bind 'alt shift R', RunAntTarget.new('produce-junit-report', 'Produce JUnit Report')
#bind 'banana F', FindFlakyTests.new

toggle_sound_dir = context.root + '/pmip/plugins/fxi/assets/'

#TODO: is a general comment in/out line?
bind 'banana COMMA', ToggleChevronTech.new(
  'System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n" + responseXml);',
  'src/java/**/WorkbenchResponse.java', toggle_sound_dir + 'cow.wav',
  'Toggle Response Chevron Tech')

bind 'banana PERIOD', ToggleChevronTech.new(
  'System.out.println("\n\n>>>>>>>>>>>>>>>>>>>>>>>>>>"+new java.util.Date()+"\n\n" + request);',
  'src/java/**/WorkbenchRequest.java', toggle_sound_dir + 'sheep.wav',
  'Toggle Request Chevron Tech')

#TODO: a bit iffy in chrome ... seems to need manual intervention
bind 'banana P', ExecuteCommand.new('regedit /s useUBSProxySettings.reg', context.filepath_from_root('tools'), 'Restore Browser Proxy')