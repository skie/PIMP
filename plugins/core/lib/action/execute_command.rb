class ExecuteCommand < PMIPAction
  def initialize(command, path='', name = "#{self.class.to_s}: #{command}")
    super(name)
    @command = command
    @path = path
  end

  def run(event, context)
    result('Running ...')
    #TODO: obviously this is windows only currently
    Run.later { `start /D#{@path.to_s.gsub('/', "\\")} #{@command}` }
  end
end