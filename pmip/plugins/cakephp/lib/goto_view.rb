class GotoView < GotoAction
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
		  goto(className, methodname, context)  #if it contains something that looks like a css, bit between "" 
		  result("#{methodname} done")  
		end
	end
  
	def goto(className, methodname, context)
	  foldersToScan = [
	    APPROOT + "/plugins/*/views",
	    APPROOT + "/Plugin/*/View"
	  ]
	  listfolders = scan_folder(context, foldersToScan)
	  listfolders.push(APPROOT + "/views/")
	  listfolders.push(APPROOT + "/View/")
	  folders = includes(["**/#{className}/**/#{methodname}.ctp"], listfolders)
	  files = Files.new
	  folders.each {|f| files.include(f)}
	  
	  results = FindInFiles.new(files).get_list(/.*/, methodname) # wrapper around ant DirectoryScanner 

	  display(results, "could not find view: #{methodname}", "Goto view for: #{methodname}")
	end  
	
end