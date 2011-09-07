class GotoElement < PMIPAction
	def run(event, context)
		line = context.current_editor.line # get the text of the current editor 
		line =~ /.*element\(['"](.*?)['"]\).*/
		elementPath = $1
		goto(elementPath) unless elementPath.nil?  #if it contains something that looks like a css, bit between "" 
	end
  
	def goto(elementPath)
	  files = Files.new.include("pfp/**/elements/#{elementPath}.ctp") # wrapper around ant DirectoryScanner 
	  results = FindInFiles.new(files).get_list(/.*/, elementPath) # wrapper around ant DirectoryScanner 

	  if results.empty?
		Balloon.new.info("could not find element: #{elementPath}") # wrapper around intellij Balloon notfier UI 
	  else
		Chooser.new("Goto element for: #{elementPath}", results). # wrapper around intellij PopupChooser and friends - like the CTRL-E chooser 
		  description {|r| r.filepath}.
		  preview_line {|r| r.content}.
		  on_selected {|r| r.navigate_to.highlight_word}. # wrapper around PsiElements, SelectionModel etc etc 
		  show
	  end
	end  
end

