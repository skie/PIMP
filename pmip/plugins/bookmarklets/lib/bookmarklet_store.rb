load 'lib/list_bookmarklets.rb'

class BookmarkletStore
  def self.start(context, port)
    assets_dir = context.root + '/pmip/plugins/bookmarklets/assets'

    mount '/assets', NonCachingFileHandler, assets_dir
    mount '/', ListBookmarklets, {:Path => assets_dir, :Port => port}

    server port
  end
end