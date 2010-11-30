load 'lib/view_test_results.rb'

port = 9319
context = PMIPContext.new

ViewTestResults.start port, context.root + '/build/results/', "src/test-*/**"

bind 'banana R', OpenURL.new("http://localhost:#{port}", 'View Test Results')