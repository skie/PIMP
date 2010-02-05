POJO_BASED = "PojoBased"

load "lib/goto_ftl_macro.rb"
load "lib/goto_gr_import.rb"
load "lib/goto_hibernate_entity.rb"
load "lib/goto_java_type.rb"
load "lib/goto_meta_data_type.rb"
load "lib/goto_named_query_or_usages.rb"
load "lib/goto_spring_bean.rb"
load "lib/goto_workflow_step.rb"
load "lib/goto_xwork_definition.rb"
load "lib/run_klondike.rb"
load "lib/run_unit_tests.rb"
load "lib/toggle_gr_feed_and_rec_rules.rb"

bind "ctrl alt shift K", RunKlondike.new(false)
bind "ctrl alt K", RunKlondike.new(true)

bind 'ctrl alt shift U', RunUnitTests.new
bind "ctrl alt shift M", GotoMetaDataType.new
bind "ctrl alt shift J", GotoJavaType.new
bind "ctrl alt shift E", GotoHibernateEntity.new
bind "ctrl alt shift Q", GotoNamedQueryOrUsages.new
bind "ctrl alt shift B", GotoSpringBean.new
bind "ctrl alt shift T", GotoFtlMacro.new
bind "ctrl alt shift X", GotoXWorkDefinition.new

bind "ctrl alt shift F", ToggleGRFeedAndRecRules.new
bind "ctrl alt shift I", GotoGrImport.new

bind "ctrl alt shift W", GotoWorkflowStep.new("Selenium")
bind "ctrl alt W", GotoWorkflowStep.new("Fake")
