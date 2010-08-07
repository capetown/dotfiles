ENV["WATCHR"] = "1"
system "clear"

BORDER = "\n=========================================================\n"

def growl(message)
  growlnotify = `which growlnotify`.chomp
  title = "Watchr Test Results"
  image = message.include?('0 failures, 0 errors') ? "~/.watchr/images/passed.png" : "~/.watchr/images/failed.png"
  options = "-w -n Watchr --image '#{File.expand_path(image)}' -m '#{message}' '#{title}'"
  system %(#{growlnotify} #{options} &)
end

def run(cmd)
  puts(cmd)
  `#{cmd}`
end

def run_test_file(file)
  result = run(%Q(ruby -I"lib:test" #{file}))
  growl result.split("\n").last rescue nil
  puts result
  puts BORDER
end

def run_associated_test_file(file)
  test_file = "test/" + file.sub("\.rb", "_test.rb")
  if File.exist?(test_file)
    run_test_file test_file
  else
    run_suite
  end
  puts BORDER
end

def run_all_tests
  result = run "rake test"
  growl result.split("\n").last rescue nil
  puts result
end

def run_suite
  system "clear"
  run_all_tests
end

watch('test/test_helper\.rb') { run_suite }
watch('test\/.*_test\.rb') { |md| run_test_file(md[0]) }
watch('lib\/(.*\.rb)') { |md| run_associated_test_file(md[1]) }

run_suite

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all tests ---\n\n"
  run_suite
end

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_suite
    @interrupted = false
  end
end