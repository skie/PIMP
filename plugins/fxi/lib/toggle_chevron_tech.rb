class ToggleChevronTech < PMIPAction
  def initialize(interesting_line, pattern, name)
    super(name)
    @interesting_line = interesting_line
    @pattern = pattern
  end

  def run(event, context)
    results = Files.new(context).include(@pattern).find
    return unless results.size == 1
    result = results.first
    Refresh.file_system_after { result.writelines(mangle(result, context)) }
  end

  private

  def mangle(file, context)
    file.readlines.collect{|line| toggle_line_if_required(line, context) }
  end

  def toggle_line_if_required(line, context)
    if line =~ /\/\// && line.include?(@interesting_line)
      report('On', context); "\t\t#{@interesting_line}"
    elsif line.include?(@interesting_line)
      report('Off', context); "\t\t//#{@interesting_line}"
    else
      line
    end
  end

  def report(status, context)
    result(status)
    Balloon.new(context).info(name + ": " + status)
  end
end