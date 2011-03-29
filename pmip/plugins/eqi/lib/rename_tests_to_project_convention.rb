class RenameTestsToProjectConvention < PMIPAction
  def run(event, context)
    #TIP - limited to first 50 for now ...
    results = Elements.new.search_class(/^Test/).select{|r| r.containing_class.nil? }#[0...50]
    if results.empty?
      Balloon.new.info("#{name}: nothing to do")
      return
    end

    names = results.collect{|r| r.name }.join(', ')
    if Dialogs.new.yes_no(name, "Found #{results.size} to rename - Are you sure?\n\n#{names}")
      rename_tests(results)
    else
      result('Aborted by user ...')
    end
  end

  private

  def rename_tests(tests)
    Run.write_action {
      refactor = Refactor.new
      progress = ProgressBar.new.start(name)
      all = tests.size
      all.times{|i| rename_test(tests[i], i, all, progress, refactor) }
      progress.finish
      refactor.commit
      result('Done')
    }
  end

  def rename_test(test, done, of, progress, refactor)
    new_name = test.name.sub(/^Test/, '') + 'Test'
    puts "- #{name}: #{test.name} -> #{new_name}"
    progress.update(done, of, "#{done} of #{of}", "#{name}:")
    refactor.rename(test, new_name)
  end
end