require 'webrick'

$mounts = {}

#TIP: borrowed from http://tobyho.com/HTTP%20Server%20in%205%20Lines%20With%20Webrick
class NonCachingFileHandler < WEBrick::HTTPServlet::FileHandler
  def prevent_caching(res)
    res['ETag']          = nil
    res['Last-Modified'] = Time.now + 100**4
    res['Cache-Control'] = 'no-store, no-cache, must-revalidate, post-check=0, pre-check=0'
    res['Pragma']        = 'no-cache'
    res['Expires']       = Time.now - 100**4
  end

  def do_GET(req, res)
    super
    prevent_caching(res)
  end
end

class Mounter
  def self.mount(url, servlet, *args)
    puts "- Mounted #{url} -> #{servlet}"
    $mounts[url] = [servlet, *args]
    self
  end
end

def mount(url, servlet, *args)
  Mounter.mount(url, servlet, args)
end

#TODO: pull out server into another class?
def server(port = 9319)
  puts "- Starting server on port: #{port}"
  Thread.new do
    $server = WEBrick::HTTPServer.new(:Port => port) if $server.nil?
    $mounts.keys.each{|url| $server.mount(url, $mounts[url][0], *$mounts[url][1]) }
    $mounts.clear
    $server.start unless $server.status == :Running
  end
end