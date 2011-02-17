#Borrowed from: http://www.centerkey.com/java/browser/

class Browser
  BROWSERS = ["google-chrome", "firefox", "opera", "epiphany", "konqueror", "conkeror", "midori", "kazehakase", "mozilla" ]

  def open(url)
    if OS.osx?
      com.apple.eio.FileManager.openURL(url)
    elsif OS.windows?
      `rundll32 url.dll,FileProtocolHandler #{url}`
    else
      BROWSERS.each{|browser| return Thread.start{`#{browser} #{url}`} unless `which #{browser}`.strip.empty? }
    end
  end
end