import com.intellij.openapi.wm.WindowManager

class StatusBar
   def initialize(context = PMIPContext.new)
     @status_bar = WindowManager.instance.get_status_bar(context.project)
   end

   def set(message)
     @status_bar.set_info(message) unless @status_bar.nil?
     self
   end

   def add(component)
     @status_bar.add_custom_indication_component(component)
     @status_bar.repaint
     self
   end

   def remove(component)
     @status_bar.remove_custom_indication_component(component)
     @status_bar.repaint
     self
   end
end