load 'lib/find_flaky_tests.rb'
load 'lib/toggle_chevron_tech.rb'

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

bind 'banana F', FindFlakyTests.new