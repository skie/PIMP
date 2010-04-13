load 'lib/fit.rb'
load 'lib/open_fit_result.rb'
load 'lib/run_fit.rb'
load 'lib/suite.rb'
load 'lib/find_unused_fit_tests.rb'

bind 'ctrl alt shift F9', RunFit.new('Debug', false)
bind 'ctrl alt shift F10', RunFit.new('Run', false)
bind 'ctrl alt shift F11', RunFit.new('Debug', true)
bind 'ctrl alt shift F12', RunFit.new('Run', true)
bind 'ctrl alt shift R', OpenFitResult.new
bind 'ctrl alt shift Y', FindUnusedFitTests.new
