class GotoCss < GotoAction
	def run(event, context)
		line = context.current_editor.line # get the text of the current editor 
		line =~ /.*class\s*=\s*"(.*?)".*/
		css = $1
		line = context.current_editor.line 
		line =~ /.*id\s*=\s*"(.*?)".*/
		id = $1
		goto(css, id, context) unless css.nil? && id.nil? #if it contains something that looks like a css, bit between "" 
	end
  
	def goto(klass, id, context)
	  foldersToScan = [
	    APPROOT + "/plugins/*/views/**/webroot", 
		APPROOT + "/plugins/*/webroot", 
		APPROOT + "/views/**/webroot",
	    APPROOT + "/Plugin/*/View/**/webroot", 
		APPROOT + "/Plugin/*/webroot", 
		APPROOT + "/View/**/webroot"
		]
	  listfolders = scan_folder(context, foldersToScan)
	  listfolders.push(APPROOT + "/webroot/")
	  folders = includes(["css/**/*.css"], listfolders)
	  files = Files.new
	  folders.each {|f| files.include(f)}
	
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
	  
	  display(results, "could not find css: #{str}, delete it!", "Goto css for: #{str}")
	end  
end

