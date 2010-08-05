load 'lib/list_differences.rb'
load 'lib/resolve_difference.rb'

HOT = "THAT'S FOR THE WIN! - check it in!"
NOT = "Not so much - I'll fix my shoddy code"
RESULT = 'result'
FILENAME = 'filename'

class ResolveImageDifferences
  def self.start(port, context = PMIPContext.new)
    snapshot_path = Path.new(context.root + '/snapshots')
    built_path = Path.new(context.root + '/build/snapshots')
    diff_path = Path.new(context.root + '/build/snapshots/diffs')

    mount '/snapshot', NonCachingFileHandler, snapshot_path.to_s
    mount '/built', NonCachingFileHandler, built_path.to_s
    mount '/diff', NonCachingFileHandler, diff_path.to_s
    mount '/', ListDifferences, {:DiffPath => diff_path}
    mount '/resolve', ResolveDifference, {:DiffPath => diff_path, :BuiltPath => built_path, :SnapshotPath => snapshot_path}

    server port
  end
end