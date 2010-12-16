load 'lib/list_bookmarklets.rb'

class BookmarkletStore
  def self.start(port, context = PMIPContext.new)
    assets_dir = '/assets'
    assets_filepath = Path.new(context.plugin_root + assets_dir)

    mount assets_dir, NonCachingFileHandler, assets_filepath.to_s
    mount '/', ListBookmarklets, {:Path => assets_filepath, :Port => port}

    server port
  end
end