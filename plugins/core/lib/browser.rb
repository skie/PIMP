#Borrowed from: http://www.centerkey.com/java/browser/

import java.lang.reflect.Method
import java.lang.System

class Browser
  BROWSERS = ["firefox", "opera", "konqueror", "epiphany", "seamonkey", "galeon", "kazehakase", "mozilla", "netscape"]

  def open(url)
    os_name = System.getProperty("os.name")
    if os_name =~ /^Mac OS/
      file_mgr = Class.forName("com.apple.eio.FileManager")
      open_url = file_mgr.getDeclaredMethod("openURL", [String.class])
      open_url.invoke(null, [url])
    elsif os_name =~ /^Windows/
      `rundll32 url.dll,FileProtocolHandler #{url}`
    else
      BROWSERS.each{|browser| return `#{browser} #{url}` unless `which #{browser}`.strip.empty? }
    end
  end
end