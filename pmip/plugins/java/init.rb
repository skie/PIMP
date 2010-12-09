load 'lib/remove_exception_from_throws_clause.rb'
load 'lib/static_import_symbol.rb'
load 'lib/static_import_type.rb'
load 'lib/toggle_access_modifier.rb'

bind 'banana E', RemoveExceptionFromThrowsClause.new
bind 'pear S', StaticImportSymbol.new
bind 'banana 8', StaticImportType.new({'Assert' => 'org.junit.Assert'})
bind 'banana A', ToggleAccessModifier.new