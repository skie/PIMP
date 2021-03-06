class FindInFiles
  def initialize(files)
    @files = files
  end

  def get_list(pattern, name)
    Refresh.file_system_before {
		@files.find.inject([]){|results, f| append_get_list(results, f, name, pattern)} 
	}
  end
  
  def pattern(pattern, name)
    Refresh.file_system_before { @files.find.inject([]){|results, f| append_result(results, f, name, pattern)} }
  end

  
  private

  def append_result(results, f, name, pattern)
    lines = f.readlines
    lines.size.times do |i|
      content = lines[i]
      if content =~ pattern
        results << FindResult.new(f, i, lines[i].index(pattern) + name.length / 2, name, content)
      end
    end
    results
  end

  def append_get_list(results, f, name, pattern)
    puts name
	results << FindResult.new(f, 1, 1, name, name)
    results
  end
end