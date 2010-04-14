context = PMIPContext.new

bind 'ctrl F11', RunAntTarget.new('gwtCompile-src/java', 'Compile GWT')
bind 'ctrl shift F11', RunAntTarget.new('deploy-gwt-css-and-images-from-intellij', 'Deploy CSS and Images')
bind 'banana I', ExecuteConfiguration.new('GWT Investor Server (real services)', 'Run', 'Run Investor' )
bind 'banana X', ExecuteCommand.new('fx.bat', context.root, 'Run FX.bat')
bind 'banana R', OpenURL.new(context.filepath_from_root('build/results/index.html'), 'View Unit Test Results')

bind 'banana P', ExecuteCommand.new('regedit /s useUBSProxySettings.reg', context.filepath_from_root('tools'), 'Restore Browser Proxy')