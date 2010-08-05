load 'lib/resolve_image_differences.rb'

port = 9321

ResolveImageDifferences.start port

bind 'banana D', OpenURL.new("http://localhost:#{port}/list", 'Resolve Image Differences')