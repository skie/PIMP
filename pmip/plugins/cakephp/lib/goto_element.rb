class GotoElement < GotoAction
	def run(event, context)
		line = context.current_editor.line # get the text of the current editor 
		line =~ /.*element\(['"](.*?)['"].*\).*/
		elementPath = $1
		goto(elementPath, context) unless elementPath.nil?  #if it contains something that looks like a css, bit between "" 
	end
  
	def goto(elementPath, context)
	  foldersToScan = [
	    APPROOT + "/plugins/*/views",
	    APPROOT + "/Plugin/*/View"
	  ]
	  listfolders = scan_folder(context, foldersToScan)
	  listfolders.push(APPROOT + "/views/")
	  listfolders.push(APPROOT + "/View/")
	  folders = includes(["**/elements/#{elementPath}.ctp"], listfolders)
	  files = Files.new
	  folders.each {|f| files.include(f)}
	  
	  results = FindInFiles.new(files).get_list(/.*/, elementPath) # wrapper around ant DirectoryScanner 

	  display(results, "could not find element: #{elementPath}", "Goto element for: #{elementPath}")
	end  
end

