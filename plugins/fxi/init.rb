bind 'ctrl F11', RunAntTarget.new('gwtCompile-src/java')
bind 'ctrl shift F11', RunAntTarget.new('deploy-gwt-css-and-images-from-intellij')
bind 'banana R', ExecuteConfiguration.new('GWT Investor Server (real services)')
bind 'banana X', ExecuteCommand.new('fx.bat', PMIPContext.new.root)