load 'lib/bookmarklet_store.rb'

port = 9320

BookmarkletStore.start port

bind 'banana B', OpenURL.new("http://localhost:#{port}", 'Bookmarklet Store')