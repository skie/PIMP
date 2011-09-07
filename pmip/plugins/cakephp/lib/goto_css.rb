class GotoCss < PMIPAction
	def run(event, context)
		line = context.current_editor.line # get the text of the current editor 
		line =~ /.*"(.*?)".*/
		css = '(\.|#)' + $1
		goto(css) unless css.nil?  #if it contains something that looks like a css, bit between "" 
	end
  
	def goto(css)
	  files = Files.new.include('pfp/webroot/css/**/*.css') # wrapper around ant DirectoryScanner 
	  results = FindInFiles.new(files).pattern(/#{css}/, css) # wrapper around ant DirectoryScanner 

	  if results.empty?
		Balloon.new.info("could not find css: #{css}, delete it!") # wrapper around intellij Balloon notfier UI 
	  else
		Chooser.new("Goto css for: #{css}", results). # wrapper around intellij PopupChooser and friends - like the CTRL-E chooser 
		  description {|r| r.filepath }.
		  preview_line {|r| r.content }.
		  on_selected {|r| r.navigate_to.highlight_word }. # wrapper around PsiElements, SelectionModel etc etc 
		  show
	  end
	end  
end

