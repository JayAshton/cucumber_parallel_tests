require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec'
require 'headless'
require 'pry'
require 'site_prism'
require 'json'
require 'redis'
require 'inifile'
require 'require_all'
require 'nokogiri'
require 'fig_newton'
require 'date'
require 'rails_helper'
require 'csv'
require 'uri'
require 'yaml'
require 'base64'

require_all 'lib'

Dir.mkdir('report/') unless Dir.exist?('report/')
Dir.mkdir('data/logging/') unless Dir.exist?('data/logging/')
Dir.mkdir('screenshots/') unless Dir.exist?('screenshots/')

# clean up temporary folders
FileUtils.rm_r Dir.glob('screenshots/*')
FileUtils.rm_r Dir.glob('report/*')
FileUtils.rm_r Dir.glob('data/downloads/*')
FileUtils.rm_r Dir.glob('data/failures/*')
FileUtils.rm_r Dir.glob('data/logging/*')

system 'clear'

DOWNLOAD_DIR = FileUtils.pwd
