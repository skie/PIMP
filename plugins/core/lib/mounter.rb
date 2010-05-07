require 'webrick'

$mounts = {}

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