 require 'yaml'

 class Stats
   def self.track(action)
     filepath = Filepath.new('stats.yaml')
     content = YAML::load(filepath.read)
     content = {} if !content
     content[action] = 0 if content[action].nil?
     content[action] = content[action].succ
     filepath.write(YAML::dump(content))
   end
 end

 def track(action)
   Stats.track(action)
 end