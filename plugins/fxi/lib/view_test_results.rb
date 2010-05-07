load 'lib/navigate_to_test.rb'
load 'lib/mangle_test_results.rb'

#TODO:
#optionally run it?
#should focus the editor/intellij?
#assets should be driven from context.plugin_root (when available)
#should mangle errors as well?
#find out why webrick often won't restart without a kick ...

class ViewTestResults
  def self.start(context, port)
    results = context.root + '/build/results/'

    mount '/NavigateToTest', NavigateToTest
    #TODO: find a nicer way to do this, ideally a pattern or something
    mount '/alltests-errors.html', MangleTestResults, {:Path => results, :Port => port, :File => 'alltests-errors.html'}
    mount '/alltests-fails.html', MangleTestResults, {:Path => results, :Port => port, :File => 'alltests-fails.html'}
    mount '/', WEBrick::HTTPServlet::FileHandler, results
    mount '/assets', WEBrick::HTTPServlet::FileHandler, context.root + '/pmip/plugins/fxi/assets'

    server port
  end
end