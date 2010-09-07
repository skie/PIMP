load 'lib/resolve_image_differences.rb'

port = 9321

ResolveImageDifferences.start port

bind 'banana D', OpenURL.new("http://localhost:#{port}", 'Resolve Image Differences')
bind 'alt shift D', RunAntTarget.new('do-image-diffing-tech', 'Re-run Image Diff')