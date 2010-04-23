
class NavigateTo < PMIPServlet
  def get(request, response, context)
    if params.has_key?('class')
      #TODO: params should be unencoded
      class_name = params['class']
      method_name = params['method'].nil? ? class_name : params['method']

      pattern = /.*#{method_name}.*/
      results = FindInFiles.new(Files.new(context).include("src/test-*/**/#{class_name}.java")).pattern(pattern, class_name)

      if results.size == 1
        result = results.first
        result(result.describe)
        result.navigate_to(context)
      else
        result("expected to find one class for: #{class_name}.#{method_name}, but found: #{results}")
      end
    end
  end
end

#TODO: rename me
class UnitTestFailures < PMIPServlet
  def get(request, response, context)
    port = @args[:Port]
    content = Filepath.new(@args[:Path] + 'alltests-fails.html').read

    #TODO: should be a HEREDOC
    content.sub!('</head>', "<script src=\"/assets/prototype.js\" type=\"text/javascript\"></script>
    <script language=\"javascript\" type=\"text/javascript\">
	function goto(class_name, method_name){
		var url = \"http://localhost:#{port}/NavigateTo\";
				var pars = \"class=\" + class_name + \"&method=\" + method_name + \"&timestamp=\" + new Date().getTime();

				var myAjax = new Ajax.Request(
					url,
					{
						method: \"get\",
						parameters: pars
					});

	}
    </script>" + "\n</head>")

    content = content.split("\n").collect{|l|
      if l =~ /^<td><a href=".*?">(.*?)<\/a><\/td>.*(<a href="(.*?)#(.*?)">(.*?)<\/a>).*/
        bit_to_replace = $2
        class_name = $1
        #TODO: this should be done in the servlet
        #TODO: params should be encoded
        method_name = $4.split(' ').first
        l.sub!(bit_to_replace, "<a title=\"open in IDE\" href=\"javascript: void(0)\" onclick=\"goto('#{class_name}', '#{method_name}')\"><img border=\"0\" src=\"/assets/openInIde.gif\" align=\"center\"></a>&nbsp;" + bit_to_replace)
      end
      l
    }.join("\n")

    response.body = content
    response['Content-Type'] = "text/html"
  end
end

#TODO:
#optionally run it?
#should focus the editor as well?
#puts $plugin