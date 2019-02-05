# Name: login_steps.rb
# Copyright 2015, Opex Software
# Apache License, Version 2.0
# This is a cucumber step-definitions file containing implementations of GWT's feature steps


Given /^I am on magento (customer|admin) page$/ do |portal|
  magento = LoginPage.new(@driver)
  magento.go_to_homepage(portal)
end

Given /^I login with username "([^"]*)" and password "([^"]*)"$/ do |uname,pass|
  magento = LoginPage.new(@driver)
  magento.login(uname,pass)
end

Then /^I logout$/ do
  magento = LoginPage.new(@driver)
  magento.logout
end

Then /^I should see ([^"]*) message for (login|registration)$/ do |type,action|
  magento = LoginPage.new(@driver)
  if action == "login"
    case type
      when "invalid_credentials"
        @driver.find_element(css: "li.error-msg span").text.should == "Invalid login or password."
        #magento.error_message.text.should == "Invalid login or password."
      when "mandatory_fields"
        sleep(1)
        magento.verify_mandatory_fields_message(action)
    end

  elsif action == "registration"
    case type
      when "mandatory_fields"
        sleep(1)
        magento.verify_mandatory_fields_message(action)
      when "existing_user"
        @driver.find_element(css: "li.error-msg span").text.should == "There is already an account with this email address. If you are sure that it is your email address, click here to get your password and access your account."
      when "new_user"
        @driver.find_element(css: "li.success-msg span").text.should == "Thank you for registering with Main Website Store."
    end
  end

end

Given /^I follow (login|register) link in account section$/ do |link|
  magento = LoginPage.new(@driver)
  @driver.find_element(css: "a.skip-account").click
  case link
    when "login"
      @driver.find_element(xpath: "/html/body/div/div/header/div/div[5]/div/ul/li[6]/a").click
    when "register"
      @driver.find_element(css: "a[title*='Register']").click
  end
end

When /^I register (?:a|an) (new|existing) user$/ do |user_type|
  magento = LoginPage.new(@driver)
  @email = magento.register(user_type)
end
