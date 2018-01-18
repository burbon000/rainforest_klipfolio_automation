#tester starts at 
# "https://app.Klipfolio.com/login"


test(id: 93385, title: "Dashboard logo - replace with account name") do
  # You can use any of the following variables in your code:
  # - []

  # Sauce Labs testing - change full configuration
  sauce_username=''
  sauce_access_key=''
  sauce_browser_name='firefox'
  sauce_browser_version='45'
  sauce_os_platform='Windows 7'
  sauce_job_name='klipfolio_dash_logo_replace'
  Capybara.register_driver :sauce do |app|
    @desired_cap = {
      'platform': "#{sauce_os_platform}",
      'browserName': "#{sauce_browser_name}",
      'version': "#{sauce_browser_version}",
      'name': "#{sauce_job_name}",
    }
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => "http://#{sauce_username}:#{sauce_access_key}@ondemand.saucelabs.com:80/wd/hub",
      :desired_capabilities => @desired_cap
    )
  end
  #Selenium testing - change browser
  selenium_browser = :chrome
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => selenium_browser)
  end

  username = ''
  password = ''
  firstname = ''
  account_name = ''
  visit "https://app.Klipfolio.com/"


  step id: 1,
      action: "Enter your username(email address): '{{qualityassuranceTesters.user}}' and password: "\
              "'{{qualityassuranceTesters.pass}}' and click on the Sign in button",
      response: "After the sign in, does your account First name: {{qualityassuranceTesters.firstname}}"\
              " show up at the top right corner of the page?" do
    # *** START EDITING HERE ***
    expect(page).to have_content('Klipfolio')

    # action
    fill_in 'username', with: username
    fill_in 'password', with: password
    page.find(:css, '#login').click

    # response
    expect(page).to have_selector(:css, '#nav-dashboard')
    expect(page).to have_content('My Dashboards')
    expect(page).to have_content(first_name)

    #page.save_screenshot('screenshot_step_1.png')
    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Perform a mouse-over of the Logo/Account name (top left corner of page) AND select the EDIT button",
      response: "Do you see the REPLACE YOUR DASHBOARD LOGO popup/dialog?" do
    # *** START EDITING HERE ***

    # action
    page.find(:css, '.header-logo').hover
    page.find(:css, '#edit-logo').click

    # response
    within(:css, '.overlay-container') do
      expect(page).to have_content('Replace Your Dashboard Logo')
      expect(page).to have_selector(:css, "img[id='upload-logo-output']")
    end

    #page.save_screenshot('screenshot_step_2.png')
    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Enable the USE MY ACCOUNT NAME INSTEAD checkbox",
      response: "Does the preview now show the ACCOUNT NAME, rather than the logo?" do
   
    # *** START EDITING HERE ***

    # action
    page.check('account-name-edit-toggle')

    # response
    expect(page).to have_no_selector(:css, "img[id='upload-logo-output']", wait: 5)

    #page.save_screenshot('screenshot_step_3.png')
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "Select the APPLY button",
      response: "Does the popup/dialog close AND is the logo (top left corner) replaced by the ACCOUNT NAME?" do
    
    # *** START EDITING HERE ***

    # action
    page.click_button('Apply changes')

    # response
    expect(page).to have_no_content('Replace Your Dashboard Logo')
    expect(page).to have_content(account_name)

    #page.save_screenshot('screenshot_step_4.png')
    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "Navigate to UserName > Account",
      response: "Does the page render with the ACCOUNT tab having focus (blue underline)?" do
   
    # *** START EDITING HERE ***
	   
    # action
    page.find(:css, '.account-dropdown').click
    page.find(:css, '#menuitem-account').click

    # response
    expect(page).to have_content('My Profile')
    expect(page).to have_selector(:css, "#nav-account[class='active']")

    #page.save_screenshot('screenshot_step_5.png')
    # *** STOP EDITING HERE ***
  end

  step id: 6,
    action: "Select the SETTINGS tab",
    response: "Does the page render with the SETTINGS tab having focus (blue underline)?" do
      
    # *** START EDITING HERE ***
      
    # action
    page.find(:css, 'a', :text => 'Settings').click
    
    # response 
    expect(page).to have_selector(:css, "#tab-settings[class='admin-tab active']")

    #page.save_screenshot('screenshot_step_6.png')
    # *** STOP EDITING HERE ***

  end
  
  
 step id: 7,
      action: "Compare the ACCOUNT NAME from the SETTINGS tab to the string displayed as the logo",
      response: "Does the ACCOUNT NAME match the string shown in place of the logo?" do

    # *** START EDITING HERE ***

    # action
    #  No action

    # response
    expect(page.find(:css, '.dashboard-name.ellipsis', :match => :first).text).to eql(page.find(:css, '#headerName').text)

    #page.save_screenshot('screenshot_step_7.png')
    # *** STOP EDITING HERE ***

  end

  step id: 8,
      action: "Perform a mouse-over of the Logo/Account name (top left corner of page) AND select the EDIT button",
      response: "Do you see the REPLACE YOUR DASHBOARD LOGO popup/dialog?" do
    # *** START EDITING HERE ***
    
    # action
    page.find(:css, '.header-logo').hover
    page.find(:css, '#edit-logo').click

    # response
    within(:css, '.overlay-container') do
      expect(page).to have_content('Replace Your Dashboard Logo')
      expect(page).to have_no_selector(:css, "img[id='upload-logo-output']")
    end

    #page.save_screenshot('screenshot_step_8.png')
    # *** STOP EDITING HERE ***

  end
  
  step id: 9,
      action: "Select the RESET button",
      response: "Does the preview now show the Klipfolio logo?" do

    # *** START EDITING HERE ***

    # action
    page.click_link_or_button 'Reset'

    # response
    within(:css, '.overlay-container') do
      expect(page).to have_selector(:css, "img[id='upload-logo-output']")
    end

    #page.save_screenshot('screenshot_step_9.png')
    # *** STOP EDITING HERE ***

  end

  
  step id: 10,
      action: "Select the APPLY button",
      response: "Does the popup/dialog close AND is the Klipfolio logo now displayed? (top left corner)" do

    # *** START EDITING HERE ***

    # action
    page.click_link_or_button('Apply')

    # response
    expect(page).to have_no_content('Replace Your Dashboard Logo')
    expect(page).to have_no_selector(:css, '.overlay-container')
    
    #page.save_screenshot('screenshot_step_10.png')
    # *** STOP EDITING HERE ***

  end

end
