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
    Refresh.file_system_after { result.writelines(mangle(result)) }
  end

  private

  def mangle(file)
    file.readlines.collect{|line| toggle_line_if_required(line) }
  end

  def toggle_line_if_required(line)
    if line =~ /\/\// && line.include?(@interesting_line)
      result('On'); "\t\t#{@interesting_line}"
    elsif line.include?(@interesting_line)
      result('Off'); "\t\t//#{@interesting_line}"
    else
      line
    end
  end
end