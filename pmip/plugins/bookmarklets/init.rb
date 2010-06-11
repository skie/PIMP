load 'lib/bookmarklet_store.rb'

context = PMIPContext.new
port = 9320

BookmarkletStore.start context, port

bind 'banana B', OpenURL.new("http://localhost:#{port}", 'Bookmarklet Store')
