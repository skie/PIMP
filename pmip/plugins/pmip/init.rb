load 'lib/search_git_source.rb'
load 'lib/search_for_intellij_class_definition.rb'
load 'lib/search_for_intellij_class_usages.rb'
load 'lib/search_in_intellij_sources.rb'

bind 'alt shift S', SearchForIntellijClassDefinition.new
bind 'alt shift U', SearchForIntellijClassUsages.new
bind 'alt shift T', SearchInIntellijSources.new