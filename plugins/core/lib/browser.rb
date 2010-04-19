#Borrowed from: http://www.centerkey.com/java/browser/

import java.lang.reflect.Method
import java.lang.System

class Browser
  BROWSERS = ["firefox", "opera", "konqueror", "epiphany", "seamonkey", "galeon", "kazehakase", "mozilla", "netscape"]

  def open(url)
    os_name = System.getProperty("os.name")
    if os_name =~ /^Mac OS/
      file_mgr = Class.forName("com.apple.eio.FileManager")
      open_url = file_mgr.getDeclaredMethod("openURL", [java.lang.String.java_class].to_java(java.lang.Class))
      open_url.invoke(nil, [url].to_java(java.lang.String))
    elsif os_name =~ /^Windows/
      `rundll32 url.dll,FileProtocolHandler #{url}`
    else
      BROWSERS.each{|browser| return `#{browser} #{url}` unless `which #{browser}`.strip.empty? }
    end
  end
end