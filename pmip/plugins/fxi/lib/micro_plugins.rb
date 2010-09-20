class MicroPlugins < PMIPAction
  def run(event, context)
    Chooser.new("Micro plugins", plugins.keys).
      description{|r| r }.
      on_selected{|r| result("#{r} - #{plugins[r].call}") }.
      show
  end

  private

  def plugins
    all = { 'Copy my GPN to clipboard' => lambda { Clipboard.set(gpn(username)) },
      'Copy my username to clipboard' => lambda { Clipboard.set(username) },
      'Copy my hostname to clipboard' => lambda { Clipboard.set(hostname) },
      'Copy my fxi localhost url to clipboard' => lambda { Clipboard.set(local_fxi_url(hostname)) }
    }
    Path.new('../cfg/servers').files('*.properties').each{|e|
      #TIP: remove the unless clause if you want prod support
      all["Open SQL*Plus Session to: #{e.base}"] = lambda { launch_sqlplus(e) } unless e.base.include?('prod')
    }
    all
  end

  def username
    System.getProperty("user.name")
  end

  def gpn(username)
    gpns = YAML::load_file("#{Dir.pwd}\\plugins\\fxi\\gpns.yaml")
    gpns.has_key?(username) ? gpns[username].to_s : Balloon.new.error("Could not find a GPN for '#{username}', please edit 'gpns.yaml'")
  end

  def hostname
    `hostname`.strip
  end

  def local_fxi_url(hostname)
    "http://#{hostname}.ubsw.net/spi/spi/fx"
  end

  def launch_sqlplus(environment_filepath)
    config = environment_filepath.readlines.inject({}){|config, l|
      bits = l.split('=')
      if bits.size == 2
        config[bits[0].strip] = bits[1].strip
      end
      config
    }

    host_bits = config['HIBERNATE_HOST'].split(':')
    host = host_bits[0]
    port = host_bits[1]
    service = config['HIBERNATE_DATABASE']
    username = config['HIBERNATE_USER']
    password = config['HIBERNATE_PASSWORD']
    env = environment_filepath.base.upcase
    colour = env.include?('PROD') ? '4f' : '2f'

    `start /D.\\plugins\\fxi\\ launch_sqlplus.bat #{colour} #{username} #{password} #{host} #{port} #{service} #{env}`
  end
end