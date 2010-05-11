import java.net.URL
import java.applet.Applet

class Sound
  def self.play(file, time = 10)
    Run.on_pooled_thread {
      Applet.newAudioClip(URL.new("file:#{file}")).play
      sleep time
    }
  end
end