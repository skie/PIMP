class GotoCss < PMIPAction
	def run(event, context)
		line = context.current_editor.line # get the text of the current editor 
		line =~ /.*class\s*=\s*"(.*?)".*/
		css = $1
		line = context.current_editor.line 
		line =~ /.*id\s*=\s*"(.*?)".*/
		id = $1
		goto(css, id) unless css.nil? && id.nil? #if it contains something that looks like a css, bit between "" 
	end
  
	def goto(klass, id)
	  files = Files.new.include(APPROOT + '/webroot/css/**/*.css') # wrapper around ant DirectoryScanner 
	  if !klass.nil?
		klass = '\.' + klass
	    resultsKlass = FindInFiles.new(files).pattern(/#{klass}/, klass) # wrapper around ant DirectoryScanner 
	  else	
	    resultsKlass = []
	  end
	  if !id.nil?
		id = '#' + id
	    resultsId = FindInFiles.new(files).pattern(/#{id}/, id) # wrapper around ant DirectoryScanner 
	  else	
	    resultsId = []
	  end
	  results = resultsKlass | resultsId
	  
      str = ''
      str = klass unless klass.nil?
      if !id.nil?
        #str = str != '' ? "#{str} and #{id}"
        if str != ''
      	  str = "#{str} and #{id}"
        else
      	  str = id
        end
      end
	  
	  puts results.count
	  if results.empty?
		Balloon.new.info("could not find css: #{str}, delete it!") # wrapper around intellij Balloon notfier UI 
	  else
		Chooser.new("Goto css for: #{str}", results). # wrapper around intellij PopupChooser and friends - like the CTRL-E chooser 
		  description {|r| r.filepath }.
		  preview_line {|r| r.content }.
		  on_selected {|r| r.navigate_to.highlight_word }. # wrapper around PsiElements, SelectionModel etc etc 
		  show
	  end
	end  
end

