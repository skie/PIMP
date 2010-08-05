class ResolveDifference < PMIPServlet
  def post(request, response, context)
    filename = @params[FILENAME]
    diff_filepath = @args[:DiffPath].create_filepath(filename)
    built_filepath = @args[:BuiltPath].create_filepath(filename)
    snapshot_filepath = @args[:SnapshotPath].create_filepath(filename)

    case @params[RESULT]
      when HOT;
        built_filepath.copy_to(snapshot_filepath)
        diff_filepath.delete
      when NOT;
        diff_filepath.delete
    end

    redirect '/'
  end
end