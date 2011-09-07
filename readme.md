# This project is a [PIMP](http://pmip.googlecode.com/) fork


## Why?

Developers rely massively on IDE's and related plugins to increase productivity with particular frameworks and technologies but there are many everyday project inefficiencies that we tend to live with, because writing IDE plugins is a massive [gumption trap](http://en.wikipedia.org/wiki/Gumption_trap). PMIP was created to remedy that by making it simple to write project specific plugins.

For further information see the slides from the '[Introduction to PMIP talk](http://pmip.googlecode.com/svn/trunk/talk/PMIP/pmip.html)' (requires a non IE browser)


## What is it?

Poor Man's IDE Plugin (PMIP) is a simple tool for extending your IDE by scripting micro plugins. PMIP plugins are by design, small, quick and easy to write, shielding the plugin writer from the complexities of the IDE's API.

Currently PMIP supports ruby scripting of [IDEA Intellij](http://www.jetbrains.com/idea/)

In a nutshell, PMIP provides:

* A host plugin that runs inside the IDE which contains an embedded jruby interpreter
* A bundle of ruby scripts that provide some simple abstractions over Intellij's plugin API 


##A Quick Example

Bind a simple action to a keypress:

	class HelloWorldAction < PMIPAction
	  def run(event, context)
		Dialogs.new(context).info('Hello World', 'Hello from PMIP!')
	  end
	end
	
	bind 'ctrl alt shift A', HelloWorldAction.new

For a more complex example see: [[PoorMansTestDox]] a port of the excellent [TestDox](http://plugins.intellij.net/plugin/?idea&id=96) plugin (always the first plugin I install).


Sounds great, how do I start writing my own plugins?

1 Follow the tutorial to get a simple plugin running: [[GettingStarted]] -> [[InstallingTheCoreBundle]] -> [[CreatingNewPlugins]] -> [[WritingActions]] -> [[BindingActions]]
2 Look at the code for some [[ExamplePlugins]]
3 Consult the [[CoreBundleApi]]
4 Got a problem? See: [[FrequentlyAskedQuestions]]
5 If you like PMIP, please rate it in the Intellij Plugin Repository 