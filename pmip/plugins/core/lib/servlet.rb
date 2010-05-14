require 'webrick'

class PMIPServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize(config, args = [])
    super
    @args = args
  end

  def self.get_instance(config, *options)
    #TODO: only do this in dev mode ....
    #puts "reloading servlet: #{self}"
    load __FILE__
    self.new(config, *options)
  end

  def do_GET(request, response)
    with(request, response) {|context| get(request, response, context) }
  end

  def do_POST(request, response)
    with(request, response) {|context| post(request, response, context) }
  end

  protected

  def result(result)
    @result = result.is_a?(Array) ? result.join(', ') : result.to_s
    @result
  end

  def params
    @params
  end

  private

  def with(request, response, &blk)
    waiting = true
    context = PMIPContext.new
    reset_result
    StatusBar.new(context).set("Running #{name} ...")
    track(name)
    Run.later do
      begin
        @params = Params.new(request.query)
        blk.call(context)
        response.status = 200
        message = "#{name}: #{@result}"
        puts "- #{message}"
        StatusBar.new(context).set(message)
      rescue => e
        message = "Error: #{e.message}:\n#{e.backtrace.join("\n")}"
        puts message
        response.body = message
        Dialogs.new(context).error("PMIP Plugin Error", "PMIP encounted an error while executing the action: " + name + "\n\n" + message + "\n\nPlease contact the plugin developer!")
        StatusBar.new(context).set(message)
      ensure
        waiting = false
      end
    end

    while waiting
      #TODO: should there be some kind of max timeout in here
    end
  end

  def name
    @name.nil? ? self.class.to_s : @name
  end

  def reset_result
    result('Nothing to do')
  end
end

#TODO: pull out class (so servlet package)
class Params
  def initialize(query)
    return if query.nil?
    @key_to_value = query
  end

  def [](key)
    @key_to_value[key]
  end

  def has_key?(key)
    @key_to_value.has_key?(key)
  end
end