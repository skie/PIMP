class Gems
  def install(gem_filename)
    gem_file_path = "#{Dir.pwd}/gems/#{gem_filename}"
    raise "unable to install gem, because: '#{gem_file_path}' does not exist" unless File.exists?(gem_file_path)
    command("install #{gem_file_path} --no-rdoc --no-ri")
  end

  def uninstall(gem_name)
    command("uninstall #{gem_name} -a")
  end

  def list
    command('list')
  end

  def command(args)
    raise "Please upgrade PMIP plugin to 0.3.0 or later" if $jruby_home.nil?

    gem_command = "gem #{args}"
    puts "> #{gem_command}"

    if OS.windows?
      jgem_command = "java -jar #{jruby_jar_file} --command j#{gem_command}".gsub('/', "\\")
      command = "cmd /c \"set GEM_HOME=#{gems_directory.gsub('/', '\\')}&&#{jgem_command}\""
      `#{command}`
    else
      raise "Sorry, gem not currently supported on: #{OS.name}"
    end
  end

  private

  def jruby_jar_file
    $jruby_home.to_s.split('!')[0].sub('jar:file:/', '')
  end

  def gems_directory
    jruby_jar_file.split('lib/jruby')[0] + 'gems'
  end
end

def gem
  Gems.new
end