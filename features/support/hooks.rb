# TEST COUNT
test_count = 0
total_tests = 0

# TO RUN BEFORE EACH SCENARIO
Before do
  # SCENARIO TIMER
  @start_timestamp = Time.now
end

AfterConfiguration do |config|
  config.on_event :test_run_started do |event|
    total_tests = event.test_cases.size
  end
end

# TO RUN AFTER EACH SCENARIO - SCREENSHOT
After do |scenario|
  # SCREENSHOT ON FAILURE CAPTURE
  if scenario.failed?
    # specify a name for the location of the screenshot
    i = "screenshots/#{Time.new.to_i} Failure in #{scenario.feature.name} - #{scenario.name}.png"

    page.within_window windows.last do # always use the last open window for the snap!
      page.save_screenshot(i, full: true)
    end
  end
end

# TO RUN AFTER EACH SCENARIO - LOGGING
After do |scenario|
  if scenario.failed?
    # MAKE NOTE OF FAILURE
    File.open('data/logging/failed_scenarios.txt', 'a') do |file|
      file.write("\n#{scenario.feature.name} - #{scenario.name}")
    end

    unless scenario.name == $current_scenario
      $current_scenario = scenario.name

      total_tests += 1
    end
  end

  # PRINT THE TEST COUNT TO THE CONSOLE
  test_count += 1
  puts "#{test_count}/#{total_tests} tests executed (#{(test_count.to_f / total_tests * 100).round(2)}% complete)"

  # LOGGING - TOTAL TEST TIME
  @end_timestamp = Time.now

  total_time = @end_timestamp - @start_timestamp

  logging_text = "\n#{total_time} - #{scenario.feature.name} - #{scenario.name}"

  environment = "Running against: #{FigNewton.environment}"
  completion_time = "\nStarted at: #{Time.now.strftime('%a, %d %b %Y %H:%M:%S')}"

  File.open('data/logging/scenario_times.txt', 'a') do |file|
    contents = File.read(file)

    file.write(environment) unless contents.include? 'Running against'
    file.write(completion_time) unless contents.include? 'Started at'

    file.write(logging_text)
  end
end

# TO RUN ON EXIT
at_exit do
  # CONSOLE REPORTING
  puts "Executed against: #{FigNewton.environment}"
  puts "Completed at: #{Time.now.strftime('%a, %d %b %Y %H:%M:%S')} "

  # FAILURE LIST
  # Check to see any failures have been logged
  unless File.file?('data/logging/failed_scenarios') == false

    # List of all failures
    all_failures = File.readlines('data/logging/failed_scenarios.txt')

    # List of failures not including flaky
    non_flaky = all_failures.group_by { |e| e }.select { |_k, v| v.size > 1 }.map(&:first)

    # List of failures not including pre-reqs
    no_prereq = non_flaky.map { |x| no_prereq.push(x) unless x.include? 'Pre-requisites' }

    # Write filtered list to file
    File.open('report/failed_scenarios.txt', 'a') do |file|
      no_prereq.each do |x|
        file.write("\n #{x.delete("\n")}")
      end
    end
  end
end
