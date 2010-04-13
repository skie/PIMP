POJO_BASED = 'PojoBased'

load 'lib/goto_meta_data_type.rb'
load 'lib/goto_java_type.rb'
load 'lib/goto_hibernate_entity.rb'
load 'lib/goto_named_query_or_usages.rb'
load 'lib/goto_spring_bean.rb'
load 'lib/goto_ftl_macro.rb'
load 'lib/goto_xwork_definition.rb'
load 'lib/toggle_gr_feed_and_rec_rules.rb'
load 'lib/goto_gr_import.rb'
load 'lib/goto_workflow_step.rb'

bind 'ctrl alt shift K', ExecuteConfiguration.new('Run Klondike', 'Run', 'RunKlondike')
bind 'ctrl alt K', ExecuteConfiguration.new('Run Klondike', 'Debug', 'DebugKlondike')

bind 'ctrl alt shift Z', ExecuteConfiguration.new('Run Klondike', 'JavaRebel', 'JRebelRunKlondike')
bind 'ctrl alt Z', ExecuteConfiguration.new('Run Klondike', 'JavaRebel Debug', 'JRebelDebugKlondike')

bind 'ctrl alt shift U', ExecuteConfiguration.new('Unit Tests', 'Run')
bind 'ctrl alt U', ExecuteConfiguration.new('Unit Tests', 'Debug')

bind 'ctrl alt shift M', GotoMetaDataType.new
bind 'ctrl alt shift J', GotoJavaType.new
bind 'ctrl alt shift E', GotoHibernateEntity.new
bind 'ctrl alt shift Q', GotoNamedQueryOrUsages.new
bind 'ctrl alt shift B', GotoSpringBean.new
bind 'ctrl alt shift T', GotoFtlMacro.new
bind 'ctrl alt shift X', GotoXWorkDefinition.new

bind 'ctrl alt shift F', ToggleGRFeedAndRecRules.new
bind 'ctrl alt shift I', GotoGrImport.new

bind 'ctrl alt shift W', GotoWorkflowStep.new('Selenium')
bind 'ctrl alt W', GotoWorkflowStep.new('Fake')
