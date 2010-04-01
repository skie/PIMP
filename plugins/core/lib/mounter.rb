require 'webrick'

$mounts = {}
$server.stop unless $server.nil?

class Mounter
  def self.mount(url, servlet, name)
    puts "- Mounted #{url} -> #{servlet}"
    $mounts[url] = [servlet, name]
    self
  end
end

def mount(url, servlet, name = "")
  Mounter.mount(url, servlet, name)
end

def server(port)
  Thread.new do
    puts "- Starting server on port: #{port}"
    $server = WEBrick::HTTPServer.new(:Port => port) if $server.nil?
    $mounts.keys.each{|url| $server.mount(url, $mounts[url][0], $mounts[url][1]) }
    $server.start
  end
end