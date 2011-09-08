class GotoView < PMIPAction
	def run(event, context)
		text = context.current_editor.document.get_text
		className = ''
		text.lines.each do |line|
		  if line =~ /.*class (\w*?)Controller\s+extends.*/
		    className = $1
		  end
		end
		className = Inflector.underscore(className)
		line = context.current_editor.line # get the text of the current editor 
		if line =~ /.*function (\w*?)\s*\(.*/
			methodname = $1
		end
		if line =~ /.*render\(["'](\w+*)["'].*/
			methodname = $1
		end
		if !(methodname.nil? || className.nil?)
		  goto(className, methodname)  #if it contains something that looks like a css, bit between "" 
		  result("#{methodname} done")  
		end
	end
  
	def goto(className, methodname)
	  files = Files.new.include(APPROOT + "/**/views/**/#{className}/**/#{methodname}.ctp") # wrapper around ant DirectoryScanner 
	  results = FindInFiles.new(files).get_list(/.*/, methodname) # wrapper around ant DirectoryScanner 

	  if results.empty?
		Balloon.new.info("could not find view: #{methodname}") # wrapper around intellij Balloon notfier UI 
	  else
		Chooser.new("Goto element for: #{methodname}", results). # wrapper around intellij PopupChooser and friends - like the CTRL-E chooser 
		  description {|r| r.filepath}.
		  preview_line {|r| r.content}.
		  on_selected {|r| r.navigate_to.highlight_word}. # wrapper around PsiElements, SelectionModel etc etc 
		  show
	  end
	end  
end

