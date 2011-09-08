load 'lib/toggle_test.rb'
load 'lib/toggle_js.rb'
load 'lib/goto_css.rb'
load 'lib/goto_element.rb'
load 'lib/goto_view.rb'
load 'lib/inflector.rb'
load 'lib/inflector_action.rb'

bind InflectorCamelizeAction.new
bind InflectorUnderscoreAction.new
bind GotoCss.new
bind GotoElement.new
bind GotoView.new

bind ToggleBetweenViewAndJs.new
bind ToggleBetweenClassAndTest.new

puts "- cakephp loaded"