Run parallel tests with:

bundle exec parallel_cucumber features/ -o "-p local -p chrome_headless -p report"

1 process per feature file

-p report = Profile for multiple reports

in cucumber.yml:
report: --format html --out report/report<%= ENV['TEST_ENV_NUMBER'] %>.html
