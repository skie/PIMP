 require 'yaml'

 class Tracker
   def self.track(action)
      filepath = Filepath.new('tracking.yaml')
      content = YAML::load(filepath.read)
      content = {} if !content
      content[action] = [] if content[action].nil?
      content[action] << Time.now
      filepath.write(YAML::dump(content))
   end
 end

 def track(action)
   Tracker.track(action)
 end
