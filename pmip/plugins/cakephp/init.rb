load 'lib/toggle.rb'
load 'lib/inflector.rb'
load 'lib/inflector_action.rb'
load 'lib/goto_css.rb'
load 'lib/goto_element.rb'
load 'lib/goto_view.rb'

register ToggleBetweenClassAndTest.new
register InflectorCamelizeAction.new
register InflectorCamelizeAction.new
register InflectorUnderscoreAction.new
register GotoCss.new
register GotoElement.new
register GotoView.new

puts "- cakephp plugin loaded"