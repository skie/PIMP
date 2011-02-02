#TODO: support editor having selection as well?
#TODO: navigate between source and test (with 'Spec')

class GotoLiftResource < PMIPAction
  def initialize(project)
    super()
    @project = project
  end

  def run(event, context)
    thing = context.current_editor.word
    return if thing.nil?

    where = ['scala', 'html', 'css', 'props', 'properties'] - [context.editor_filepath.extension]
    files = Files.new.exclude("#{@project}/target/**/*")
    where.each{|w| files.include("#{@project}/**/*.#{w}") }

    results = FindInFiles.new(files).pattern(/#{thing}/, thing)

    if results.empty?
      message = "could not find anything in '#{@project}' for: #{thing}"
      result(message)
      Balloon.new.info(message)
    else
      result("found #{results.size} usages of: #{thing}#{results}")

      Chooser.new("Goto: #{thing} in '#{@project}'", results).
        description{|r| "#{r.line} - #{r.filepath.replace(context.root, '')}" }.
        preview_line{|r| r.content.to_s }.
        on_selected{|r| r.navigate_to.highlight_word }.
        show
    end
  end
end
