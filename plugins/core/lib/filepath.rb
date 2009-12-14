class Filepath
  def initialize(filepath)
    @filepath = filepath.gsub('\\', '/')
  end

  def write_lines(lines)
    File.open(@filepath,'w') {|f| f.puts lines }
  end

  def to_s
    @filepath
  end

  def ends?(value)
    match(/.*\/(.*?)#{value}$/)
  end

  def exist?
    File.exist?(@filepath)
  end

  def name
    @filepath.split('/').last
  end

  #TODO: not a good name, and probably shouldn't be on filepath
  def reduce(text)
    #TODO: blow up if text not in filepath
    index = @filepath.index(text)
    @filepath[index..-1].to_s
  end

  private

  def match(regexp)
    @filepath.match(regexp)
  end
end
