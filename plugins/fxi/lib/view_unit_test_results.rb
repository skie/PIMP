
class NavigateTo < PMIPServlet
  def get(request, response, context)
    if params.has_key?('class')
      name = params['class']
      results = Elements.new(context).find_class(name)
      if results.size == 1
        result(name + " -> " + results.first.getQualifiedName)
        Navigator.new(context).open(results.first)
      else
        result("expected to find one class for: #{name}, but found: #{results}")
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
	function goto(name){
		var url = \"http://localhost:#{port}/NavigateTo\";
				var pars = \"class=\" + name + \"&timestamp=\" + new Date().getTime();

				var myAjax = new Ajax.Request(
					url,
					{
						method: \"get\",
						parameters: pars
					});

	}
    </script>" + "\n</head>")

    content = content.split("\n").collect{|l|
      if l =~ /^<td>(<a href="(.*?)">(.*?)<\/a>)<\/td>.*/
        l.sub!($1, '<a title="open in IDE" href="javascript: void(0)" onclick="goto(\'' + $3 + '\')"><img border="0" src="/assets/openInIde.gif" align="center"></a>&nbsp;' + $1)
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