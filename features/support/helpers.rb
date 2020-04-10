module Helpers
  def load_user_details(user_type)
    user = JSON.parse(IO.read(File.open("data/users/#{FigNewton.users}.json")))

    user[user_type]
  end

  def table_data(table)
    k = table.headers
    v = table.rows.first

    Hash[[k, v].transpose]
  end

  def multi_hash_table(table)
    array = []

    table.rows.each { |row| array.push(Hash[[table.headers, row].transpose]) }

    array
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop do
        active = page.evaluate_script('jQuery.active')
        break if active.zero?
      end
    end
  end

  def print_screen
    page.within_window windows.last do
      page.save_screenshot("screenshots/#{Time.new.to_i} print_screen.png", full: true)
    end
  end
end

def write_to_custom_log(data)
  File.open('data/logging/custom_log.txt', 'a') do |file|
    File.read(file)

    file.write(data)
  end
end

World(Helpers)
