class ViewChevronTech < PMIPAction
  def initialize(config, filepath, name)
    super(name)
    @config = config
    @filepath = filepath
  end

  def run(event, context)
    results = read_items

    if results.empty?
      message = "could not find any #{@config.kind}s in #{@filepath}"
      result(message)
      Balloon.new(context).info(message)
    else
      result("found #{results.size} #{@config.kind}s in #{@filepath}")

      Chooser.new("Choose a #{@config.kind} to copy to the clipboard ...", results, context).
        description{|r| r.summarise }.
        preview_box{|r| r.content }.
        on_selected{|r| Clipboard.set(r.content) }.
        show
    end
  end

  def read_items
    current = nil
    @filepath.readlines.inject([]){|items, l|
      stripped_l = l.strip
      case stripped_l
        when @config.start_matcher
        current = @config.create_item($1)
        items << current
        when @config.finish_matcher
        current = nil
        else
        current << l.chomp unless current.nil?
      end
      items
    }.reverse
  end
end

class ChevronConfig
  REQUEST = '>>>>>>>>>>>>>>>>>>>>>>>>>>(.*)'
  RESPONSE = '<<<<<<<<<<<<<<<<<<<<<<<<<<(.*)'

  attr_reader :start_matcher, :finish_matcher, :kind

  def self.request
    ChevronConfig.new(REQUEST, 'request', lambda {|date| RequestItem.new(date)} )
  end

  def self.response
    ChevronConfig.new(RESPONSE, 'response', lambda {|date| ResponseItem.new(date)})
  end

  def create_item(date)
    @create.call(date)
  end

  private

  def initialize(matcher, kind, creator)
    @start_matcher = /START#{matcher}/
    @finish_matcher = /FINISH#{matcher}/
    @kind = kind
    @create = creator
  end
end

class Item
  def initialize(date)
    @date = date
    @lines = []
  end

  def << (line)
    @lines << line
  end

  def content
    @lines.join("\n")
  end
end

class RequestItem < Item
  def summarise
    result = [@date]
    @lines.each{|l|
      case l.strip
        when /<Resource assetClass="FX" name="(.*?)" action="(.*?)">/
          result << $2 unless $2.empty?
          result << $1 unless $1.empty?
        when /<Parameter name=".*?">(.*?)<\/Parameter>/
          result << $1 unless $1.empty?
      end
    }
    result.uniq.join(" - ")
  end
end

class ResponseItem < Item
  def summarise
    result = [@date]
    @lines.each{|l|
      case l.strip
        when /<Reply status="(.*?)"/
          result << $1 unless $1.empty?
        when /.*<Message.*>(.*)/
          result << $1 unless $1.empty?
        when /.*<Content context="(.*?)">/
          result << $1 unless $1.empty?
        when /<Parameter value="(.*?)" name="quoteState"\/>/
          result << $1 unless $1.empty?
        when /<Value name="Product">(.*?)<\/Value>/
          result << $1 unless $1.empty? || $1.include?('_')
        when /tradeId="(.*?)"/
          result << $1 unless $1.empty?
        when /<Value name="QueryType">(.*?)<\/Value>/
          result << $1 unless $1.empty?
        when /<Value name="BiProduct">(.*?)<\/Value>/
          result << $1 unless $1.empty?
      end
    }
    result.uniq.join(" - ")
  end
end
