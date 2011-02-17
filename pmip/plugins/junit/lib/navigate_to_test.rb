class NavigateToTest < PMIPServlet
  def get(request, response, context)
    if params.has_key?('class')
      class_name = params['class']
      method_name = method_name_or_default_to(class_name)
      full_name = "#{class_name}.#{method_name}"

      pattern = /.*#{method_name}.*/
      results = FindInFiles.new(Files.new.include("#{@args[:TestSrcPattern]}/#{class_name}.java")).pattern(pattern, method_name)

      if results.empty?
        result("expected to find one class for: #{full_name}")
      else
        result("found #{results.size} types for: #{full_name} - #{results.join(', ')}")

        Chooser.new("Navigate to: #{full_name}", results).
          description{|r| "#{r}" }.
          on_selected{|r| r.navigate_to; Focus.ide }.
          show
      end
    end
  end

  private

  def method_name_or_default_to(class_name)
    params['method'].nil? ? class_name : mangle_for_junit_parameterized(params['method'])
  end

  def mangle_for_junit_parameterized(method)
    method.split(' ').first
  end
end