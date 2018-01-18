#tester starts at 
# "https://app.Klipfolio.com/login"


test(id: 87012, title: "Master Dashboard 1 visual verification") do
  # You can use any of the following variables in your code:
  # - []

  # Sauce Labs testing - change full configuration
  sauce_username=''
  sauce_access_key=''
  sauce_browser_name='firefox'
  sauce_browser_version='45'
  sauce_os_platform='Windows 7'
  sauce_job_name='klipfolio_master_dash_1'
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
  
  visit "https://app.Klipfolio.com/login"

  step id: 1,
      action: "Enter your username(email address): '{{qualityassuranceTesters.user}}' and password: "\
              "'{{qualityassuranceTesters.pass}}' and click on the Sign in button",
      response: "After the sign in, does your account First name: {{qualityassuranceTesters.firstname}}"\
                " show up at the top right corner of the page?" do
    # *** START EDITING HERE ***
    
    expect(page).to have_content('Klipfolio')
    username = ''
    password = ''

    # action
    fill_in 'username', with: username
    fill_in 'password', with: password
    page.find(:css, '#login').click

    # response
    expect(page).to have_selector(:css, '#nav-dashboard')
    expect(page).to have_content('My Dashboards')

    #page.save_screenshot('screenshot_step_1.png')
    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Select the 'Master Dashboard 1' tab",
      response: "Do all visualizations on this tab render with data?" do
    # *** START EDITING HERE ***
    
    # action
    within(:css, '#dashboard-tabs') do
      page.find(:css, 'li', :text => 'Master Dashboard 1').click
    end
    
    # response
    within(:css, '.klip', :text => 'News Reader - Sample') do
      expect(page).to have_selector(:css, "tr[class='item']", :match => :first, :visible => true)
    end
    
    expect(page).to have_content('Klip Gallery Usage by User Type')
    expect(page).to have_content('Map - Sample 2')
    expect(page).to have_content('Wait time: ')
    expect(page).to have_content('Table with Drill Down - Sample')
    
    #page.save_screenshot('screenshot_step_2.png')
    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Locate the table visualization with the title 'Table with Drill Down - Sample' .",
      response: "Are the values in this table visualization the same as these values here: screenshot.png" do   
    # *** START EDITING HERE ***

    # action
      #Do nothing
      
    # response
    expected_text = ['Country City Average Score Amount', 'Canada 4 19 $38,145', 'USA 4 30 $36,248', 'Germany 4 33 $32,236', '27 $106,629']
    within(:css, '.klip', :text => 'Table with Drill Down - Sample') do
      table_rows = page.all(:css, 'tr', :count => 5, wait: 15)
      for i in 0...table_rows.length do
        expect(expected_text.include? table_rows[i].text).to eql(true)
      end
    end
    # added so it is easier to see behavior during replay
    sleep(1)

    #page.save_screenshot('screenshot_step_3.png')
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "On the table visualization with the title 'Table with Drill Down - Sample', click on the 'Canada' link.",
      response: "Are the values in this table visualization the same as these values here: screenshot.png?" do
    
    # *** START EDITING HERE ***

    # action
    within(:css, '.klip', :text => 'Table with Drill Down - Sample') do
      page.find(:css, 'td', :text => 'Canada').click
    end

    # response
    expected_text = ['City Score Amount', 'Vancouver 10 $11,726', 'Toronto 20 $8,437', 'Ottawa 12 $7,938',
                     'Montreal 33 $10,044', '19 $38,145']
    within(:css, '.klip', :text => 'Table with Drill Down - Sample') do
      table_rows = page.all(:css, 'tr', :count => 6, wait: 15)
      for i in 0...table_rows.length do
        expect(expected_text.include? table_rows[i].text).to eql(true)
      end
    end
    # added so it is easier to see behavior during replay
    sleep(1)

    #page.save_screenshot('screenshot_step_4.png')
    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "On the table visualization with the title 'Table with Drill Down - Sample', click the back button top left.",
      response: "Are the values in this table visualization the same as these values here: screenshot.png ?" do
   
    # *** START EDITING HERE ***
	   
    # action
    page.find(:css, '.ddpath-back').click

    # response
    expected_text = ['Country City Average Score Amount', 'Canada 4 19 $38,145', 'USA 4 30 $36,248', 
                     'Germany 4 33 $32,236', '27 $106,629']
    within(:css, '.klip', :text => 'Table with Drill Down - Sample') do
      table_rows = page.all(:css, 'tr', :count => 5, wait: 15)
      for i in 0...table_rows.length do
        expect(expected_text.include? table_rows[i].text).to eql(true)
      end
    end
    # added so it is easier to see behavior during replay
    sleep(1)

    #page.save_screenshot('screenshot_step_5.png')
    # *** STOP EDITING HERE ***
  end

end
