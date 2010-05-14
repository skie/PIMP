class Suite
  def initialize(context, filename)
    @context = context
    @filename = filename
  end

  def create(tests)
   @context.filepath_from_root(@filename).writelines(tests)
  end
end
