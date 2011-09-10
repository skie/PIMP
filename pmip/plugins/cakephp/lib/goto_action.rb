class GotoAction < PMIPAction

	def display(results, fail_message, success_message) 
	  if results.empty?
		Balloon.new.info(fail_message) # wrapper around intellij Balloon notfier UI 
	  else
		Chooser.new(success_message, results). # wrapper around intellij PopupChooser and friends - like the CTRL-E chooser 
		  description {|r| r.filepath}.
		  preview_line {|r| r.content}.
		  on_selected {|r| r.navigate_to.highlight_word}. # wrapper around PsiElements, SelectionModel etc etc 
		  show
	  end	    
	end

	def scan_folder(context, paths)
	  files = Files.new
	  paths.each {|path| files.include(path)}
	  
	  list = []
      Refresh.file_system_before {
	    list = files.find_dir
		list = list.map {|s| tmp = s.to_s; tmp[context.root + "/"] = ""; tmp + "/"}
	  } 
     list	  
	end

    def includes(masks, folders)	
	  result = []
	  folders.each do |folder|
	    masks.each do |mask|
		  result.push (folder + mask)		  
		end
	  end
	  result
	end
end

