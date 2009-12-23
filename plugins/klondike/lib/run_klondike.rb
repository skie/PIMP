class RunKlondike < PMIPAction
  SERVER = "http://localhost:8898";

  def initialize(no_browser)
    super("RunKlondike" + (no_browser ? "NoBrowser" : ""))
    @no_browser = no_browser
  end

  def run(event, context)
    result(SERVER)
    RunConfiguration.new(context).choose("Run Klondike").run("Run", event.presentation)

    #TODO: ping the port instead? and remove FQN - use httpclient?
    Run.later { sleep(45); Browser.new.open(SERVER + "/klondike/development.html") } unless @no_browser
  end
end