import javax.swing.JProgressBar

class ProgressBar
   def initialize(context = PMIPContext.new)
     @status_bar = StatusBar.new(context)
     @label = JLabel.new
     @progress_bar = JProgressBar.new
     @progress_bar.set_string_painted(true)
   end

   def start(text='', label='', tool_tip='')
     Run.on_pooled_thread {
       @progress_bar.set_indeterminate(true)
       @status_bar.add(@label).add(@progress_bar)
       @progress_bar.set_string(text)
       @progress_bar.set_tool_tip_text(tool_tip)
       @label.set_text(label)
     }
   end

   def finish
     Run.on_pooled_thread {
       @progress_bar.set_value(@progress_bar.maximum)
       @status_bar.remove(@label).remove(@progress_bar)
     }
   end

   def update(done, of, text='', label='', tool_tip='')
     Run.on_pooled_thread {
       @progress_bar.set_indeterminate(false)
       @progress_bar.set_value(done)
       @progress_bar.set_maximum(of)
       @progress_bar.set_string(text)
       @progress_bar.set_tool_tip_text(tool_tip)
       @label.set_text(label)
     }
   end
end