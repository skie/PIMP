#TIP: uses PrcView - http://download.cnet.com/PrcView/3000-2086_4-10025832.html
#TIP: includes tweaks from http://kadaitcha.cx/xp/performance.html
class OptimiseDevelopmentEnvironment < PMIPAction
  def run(event, context)
    if OS.windows?
      set_priority(mcaffe_processes, 'Idle')
      set_priority(['tsvncache.exe'], 'Idle')
      disable_last_access_timestamp
      set_win32_priority_seperation
    end
  end

  private

  def all_processes
    `#{"#{plugin_root}/pv -e"}`.split("\n")
  end

  def mcaffe_processes
    all_processes.select{|l| l.downcase.include?('mcafee') }.collect{|m| m.split(" ").first } + ['mfevtps.exe']
  end

  def set_priority(processes, priority)
    processes.each{|p|
      check = `#{plugin_root}/pv -p"#{priority}" #{p}`.split("\n").first.strip
      raise "failed to set priority to #{priority} for #{p}" unless check.include?("Setting priority to #{priority} for '#{p}'")
    }
  end

  def disable_last_access_timestamp
    `FSUTIL behavior set disablelastaccess 1`
    check = `FSUTIL behavior query disablelastaccess`
    raise "failed to disablelastaccess" unless '1' == check.split('=').last.strip
  end

  def set_win32_priority_seperation
    `regedit /s #{plugin_root}/win32_priority_seperation.reg`
    #TODO: check it
  end
end
