 require 'yaml'

 class Stats
   def self.track(action)
     content = load
     content[action] = 0 if content[action].nil?
     content[action] = content[action].succ
     filepath.write(YAML::dump(content))
   end

   def self.usages(action)
     content = load
     content[action].nil? ? 0 : content[action]
   end

   private

   def self.load
     content = YAML::load(filepath.read)
     content ? content : {}
   end

   def self.filepath
     Filepath.new('stats.yaml')
   end
 end

 def track(action)
   Stats.track(action)
 end

 def usages(action)
   Stats.usages(action)
 end