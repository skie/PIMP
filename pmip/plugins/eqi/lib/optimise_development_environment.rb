#TIP: uses PrcView - http://download.cnet.com/PrcView/3000-2086_4-10025832.html
class OptimiseDevelopmentEnvironment < PMIPAction
  def run(event, context)
    if OS.windows?
      set_priority(mcaffe_processes, 'Idle')
      set_priority('tsvncache.exe', 'Idle')
      disable_last_access_timestamp
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
    processes.each{|p| puts `#{plugin_root}/pv -p"#{priority}" #{p}`.split("\n").first.strip }
  end

  def disable_last_access_timestamp
    `FSUTIL behavior set disablelastaccess 1`
    puts `FSUTIL behavior query disablelastaccess`
  end
end
