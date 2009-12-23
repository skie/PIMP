class RunKlondike < PMIPAction
  SERVER = "http://localhost:8898";

  def run(event, context)
    result(SERVER)
    RunConfiguration.new(context).choose("Run Klondike").run("Run", event.presentation)

    #TODO: ping the port instead? and remove FQN - use httpclient?
    Run.later { sleep(45); Browser.new.open(SERVER + "/klondike/development.html") }
  end
end