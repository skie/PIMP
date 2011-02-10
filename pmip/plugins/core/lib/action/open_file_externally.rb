class OpenFileExternally < PMIPAction
  def run(event, context)
    raise "currently only supported on windows" unless OS.windows?
    #TIP: this cannot be changed to virtual_file because it fails on plugins written in scala (e.g. scala plugin)
    selected = context.selected_psi_elements.collect{|e| e.getVirtualFile.path}.each{|u|
      `rundll32 url.dll,FileProtocolHandler #{u}`
    }
    result(selected.join(', '))
  end
end