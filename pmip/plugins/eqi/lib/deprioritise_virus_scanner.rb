#TIP: uses PrcView - http://download.cnet.com/PrcView/3000-2086_4-10025832.html
class DeprioritiseVirusScanner < PMIPAction
  def run(event=nil, context=nil)
    mcaffe_processes.each{|p| set_priority(p, 'Idle') }
  end

  private

  def all_processes
    `#{"#{plugin_root}/pv -e"}`.split("\n")
  end

  def mcaffe_processes
    all_processes.select{|l| l.downcase.include?('mcafee') }.collect{|m| m.split(" ").first }
  end

  def set_priority(p, priority)
    puts `#{plugin_root}/pv -p"#{priority}" #{p}`.split("\n").first.strip
  end
end
