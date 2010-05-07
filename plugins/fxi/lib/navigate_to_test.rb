class NavigateToTest < PMIPServlet
  def get(request, response, context)
    if params.has_key?('class')
      class_name = params['class']
      method_name = method_name_or_default_to(class_name)

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

  private

  def method_name_or_default_to(class_name)
    params['method'].nil? ? class_name : mangle_for_junit_parameterized(params['method'])
  end

  def mangle_for_junit_parameterized(method)
    method.split(' ').first
  end
end