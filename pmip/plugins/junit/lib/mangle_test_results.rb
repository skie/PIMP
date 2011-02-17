class MangleTestResults < PMIPServlet
  def get(request, response, context)
    content = Filepath.new(@args[:Path] + @args[:File]).read
    inject_goto_function_into_head_section(content, @args[:Port])
    response.body = content.split("\n").collect{|l| inject_open_in_ide_link_into_any_test_method_links(l) }.join("\n")
  end

  private

  def inject_open_in_ide_link_into_any_test_method_links(l)
    if l =~ /^<td><a href=".*?">(.*?)<\/a><\/td>.*(<a href="(.*?)#(.*?)">(.*?)<\/a>).*/
      bit_to_replace = $2
      class_name = URI.escape($1)
      method_name = URI.escape($4.first)
      l.sub!(bit_to_replace, "<a title=\"open in IDE\" href=\"javascript: void(0)\" onclick=\"goto('#{class_name}', '#{method_name}')\"><img border=\"0\" src=\"/assets/openInIde.gif\" align=\"center\"></a>&nbsp;" + bit_to_replace)
    end
    l
  end

  def inject_goto_function_into_head_section(content, port)
  injection = <<CONTENT
<script src="/assets/prototype.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function goto(class_name, method_name){
		var url = "http://localhost:#{port}/NavigateToTest";
		var pars = "class=" + class_name + "&method=" + method_name + "&timestamp=" + new Date().getTime();
		var myAjax = new Ajax.Request(url, {method: "get", parameters: pars});
	}
</script>
</head>
CONTENT
    content.sub!('</head>', injection)
  end
end