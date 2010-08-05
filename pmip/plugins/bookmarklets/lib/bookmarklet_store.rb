load 'lib/list_bookmarklets.rb'

class BookmarkletStore
  def self.start(port, context = PMIPContext.new)
    assets_filepath = Path.new(context.root + '/pmip/plugins/bookmarklets/assets')

    mount '/assets', NonCachingFileHandler, assets_filepath.to_s
    mount '/', ListBookmarklets, {:Path => assets_filepath, :Port => port}

    server port
  end
end