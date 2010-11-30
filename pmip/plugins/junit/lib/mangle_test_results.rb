#TODO: sort out total disgrace
class MangleTestResults < PMIPServlet
  def get(request, response, context)
    port = @args[:Port]

    #TODO: handle it not being there
    #TODO: make Path be a Path
    content = Filepath.new(@args[:Path] + @args[:File]).read

    #TODO: make method inject ajax
    #TODO: should be a HEREDOC <<CONTENT
    content.sub!('</head>', "<script src=\"/assets/prototype.js\" type=\"text/javascript\"></script>
    <script language=\"javascript\" type=\"text/javascript\">
	function goto(class_name, method_name){
		var url = \"http://localhost:#{port}/NavigateToTest\";
				var pars = \"class=\" + class_name + \"&method=\" + method_name + \"&timestamp=\" + new Date().getTime();

				var myAjax = new Ajax.Request(
					url,
					{
						method: \"get\",
						parameters: pars
					});

	}
    </script>" + "\n</head>")

    #TODO: method mangle
    content = content.split("\n").collect{|l|
      if l =~ /^<td><a href=".*?">(.*?)<\/a><\/td>.*(<a href="(.*?)#(.*?)">(.*?)<\/a>).*/
        bit_to_replace = $2
        class_name = URI.escape($1)
        #TODO: this should be done in the servlet
        method_name = URI.escape($4.first)
        l.sub!(bit_to_replace, "<a title=\"open in IDE\" href=\"javascript: void(0)\" onclick=\"goto('#{class_name}', '#{method_name}')\"><img border=\"0\" src=\"/assets/openInIde.gif\" align=\"center\"></a>&nbsp;" + bit_to_replace)
      end
      l
    }.join("\n")

    response.body = content
  end
end