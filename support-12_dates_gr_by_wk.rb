#tester starts at 
# "https://app.Klipfolio.com/login"


test(id: 92243, title: "Support.12 - dates grouped by week") do
  # You can use any of the following variables in your code:
  # - []
  Capybara.register_driver :sauce do |app|
    @desired_cap = {
      'platform': "Windows 7",
      'browserName': "firefox",
      'version': "45",
      'name': "klipfolio_support_12",
    }
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => 'http://RFAutomation:5328f84f-5623-41ba-a81e-b5daff615024@ondemand.saucelabs.com:80/wd/hub',
      :desired_capabilities => @desired_cap
    )
  end

  rand_num=Random.rand(899999999) + 100000000
  
  visit "https://app.Klipfolio.com/"
  window = Capybara.current_session.driver.browser.manage.window
  #window.resize_to(960,1024)
  #window.maximize

  step id: 1,
      action: "Enter your username(email address): '{{qualityassuranceTesters.user}}' and password: "\
              "'{{qualityassuranceTesters.pass}}' and click on the Sign in button",
      response: "After the sign in, does your account First name: {{qualityassuranceTesters.firstname}}"\
                " show up at the top right corner of the page?" do
    # *** START EDITING HERE ***
    expect(page).to have_content('Klipfolio')
    username = ''
    password = ''
    first_name = ''

    # action
    fill_in 'username', with: username
    fill_in 'password', with: password
    page.find(:css, '#login').click

    # response
    expect(page).to have_selector(:css, '.account-dropdown', :text => first_name)
    expect(page).to have_content('My Dashboards')


    page.save_screenshot('screenshot_step_1.png')
    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Open the '{{klipfolioCustomVariables.dashboardName_support}}' dashboard by selecting its tab",
      response: "Does the '{{klipfolioCustomVariables.dashboardName_support}}' dashboard open?" do
    # *** START EDITING HERE ***
    
    # action
    within(:css, '#dashboard-tabs-container') do
      for i in 1..5 do
        if page.has_selector?(:css, '.btn-scroll.right-scroll', wait: 3)
          page.find(:css, '.btn-scroll.right-scroll').click
        end
        if page.has_selector?(:css, 'li', :text => 'Support Klips (Applied Actions)', wait: 1)
          page.find(:css, 'li', :text => 'Support Klips (Applied Actions)').click
          break
        end
      end
    end
    
    # response
    expect(page).to have_selector(:css, ".dashboard-tab.active[title='Support Klips (Applied Actions)']", wait: 30)
    expect(page).to have_content('Klip 12')

    
    page.save_screenshot('screenshot_step_2.png')
    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Scroll down the page and verify that visualization 'Klip 12' renders successfully.",
      response: "Does 'Klip 12' render with 2 drop-down list (Country and Medium) and a Table with 2 columns (Dates and Sessions)?" do
   
    # *** START EDITING HERE ***

    # action
      #Do nothing

    # response
    within(:css, '.klip', :text => 'Klip 12') do
      expect(page).to have_content('Country')
      expect(page).to have_content('Medium')
      expect(page).to have_content('Dates')
      expect(page).to have_content('Sessions')
      expect(page.all(:css, 'th').count).to eql(2)
    end

    page.save_screenshot('screenshot_step_3.png')
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "Scroll down the rows in the Table and note the Dates displayed",
      response: "Are the dates grouped by weeks? format = YYYY-## . ie 2000-12 is 12th week of year 2000" do
    
    # *** START EDITING HERE ***

    # action
      #Do nothing

    # response
    within(:css, '.klip', :text => 'Klip 12') do
      #within(:css, 'tr', :match => :first) do
        first_date = page.find(:css, 'td', :match => :first).text
        puts first_date
        first_date_split = first_date.split('-')
        year = first_date_split[0].to_i
        expect(year >= 2000).to eql(true)
        expect(year <= 2018).to eql(true)
        week = first_date_split[1].to_i
        expect(week > 0).to eql(true)
        expect(week < 54).to eql(true)
      #end
    end

    page.save_screenshot('screenshot_step_4.png')
    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "Verify that the values for the Dates column are sorted in ascending order",
      response: "Are the values in ascending order?" do
   
    # *** START EDITING HERE ***
	   
    # action
      #do nothing

    # response
    within(:css, '.klip', :text => 'Klip 12') do
      #within(:css, 'tr', :match => :first) do
        date_elements = page.all(:css, 'td', :visible => false)
        date_texts = []
        for i in 0..date_elements.length-1 do
          if i.even?
            date_texts.push(date_elements[i].text.delete('-'))
          end
        end
        date_texts = date_texts.reject(&:empty?)
        expect(date_texts == date_texts.sort).to eql(true)
      #end
    end

    page.save_screenshot('screenshot_step_5.png')
    # *** STOP EDITING HERE ***
  end

  step id: 6,
      action: "On Klip 12, Change the Medium drop-down to 'Chat' THEN count how many rows of data are returned.",
      response: "Are there only 3 rows of data in the Table? (2016-43, 2017-26, and 2017-28)" do
   
    # *** START EDITING HERE ***
     
    # action
    within(:css, '.klip', :text => 'Klip 12') do
      page.select 'Chat'
    end

    # response
    expected_texts = ['2016-43', '2017-26', '2017-28']
    within(:css, '.klip', :text => 'Klip 12') do
      #within(:css, 'tr', :match => :first) do
        date_elements = page.all(:css, 'td', :visible => true, :count => 6)
        for i in 0..date_elements.length-1 do
          if i.even?
            expect(expected_texts.include? date_elements[i].text).to eql(true)
          end
        end
      #end
    end

    page.save_screenshot('screenshot_step_5.png')
    # *** STOP EDITING HERE ***
  end

end
