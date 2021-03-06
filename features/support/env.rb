# Name: env.rb
# Copyright 2015, Opex Software
# Apache License, Version 2.0
# This file contains requiring all the dependencies required to execute the tests

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'cucumber'
require 'rake'
require 'json'
require 'faker'

include RSpec::Matchers

#include SeleniumFury::SeleniumWebDriver::CreateSeleniumWebDriver

require File.dirname(__FILE__) + "/../support/driver_config"
require File.dirname(__FILE__) + "/../support/utilities"
include TestNowRubyExample
