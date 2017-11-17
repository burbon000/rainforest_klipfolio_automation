#tester starts at 
# https://


test(id: 90753, title: "Changing public link to a private link") do
  # You can use any of the following variables in your code:
  # - []
  Capybara.register_driver :sauce do |app|
    @desired_cap = {
      'platform': "Windows 7",
      'browserName': "firefox",
      'version': "45",
      'name': "klipfolio_change_public_link",
    }
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => 'http://RFAutomation:5328f84f-5623-41ba-a81e-b5daff615024@ondemand.saucelabs.com:80/wd/hub',
      :desired_capabilities => @desired_cap
    )
  end  
  rand_num=Random.rand(899999999) + 100000000
  link_text = ''
  visit "https://app.Klipfolio.com/"
  window = Capybara.current_session.driver.browser.manage.window
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
    firstname = ''

    # action
    fill_in 'username', with: username
    fill_in 'password', with: password
    page.find(:css, '#login').click

    # response
    expect(page).to have_selector(:css, '#nav-dashboard')
    expect(page).to have_content('My Dashboards')
    expect(page).to have_content(firstname)

    #page.save_screenshot('screenshot_step_1.png')
    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Click on 'Published Links' tab, click on tab's 3 dots (hamburger menu) > Share > Publish link to dashboard...",
      response: "Does the Publish Link to Dashboard dialog or a pop up show up?" do
    # *** START EDITING HERE ***

    # action
    page.find(:css, 'li', :text => 'Published Links').click
    expect(page).to have_selector(:css, ".dashboard-tab.active[title='Published Links']")
    page.find(:css, '.three-dots').click
    page.find(:css, '#menuitem-share_tab').hover
    page.find(:css, '#menuitem-publish_tab').click


    # response
    expect(page).to have_selector(:css, '.overlay-container', wait: 30)
    expect(page).to have_content('Share a view-only copy of this dashboard with users outside your account.')

    #page.save_screenshot('screenshot_step_2.png')
    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Set the Visibility to 'Public and available via search', overwrite the Dashboard Name by typing 'my link',"\
              " set the Theme to DARK, then click on the PUBLISH NOW button.",
      #response: "Do you see a new dialog or a pop up? (You’re about to make this dashboard accessible by the public.)" do
      response: "Do you see a new dialog or a pop up? (Congrats! You're one step away from making your dashboard public.)" do

    # *** START EDITING HERE ***

    # action
    within(:css, '.overlay-container') do
      page.fill_in 'name', with: 'my link'
      page.choose('Public and available via search')
      page.select 'Dark', :from => 'theme'
      page.click_link_or_button('Publish Now')
    end

    # response

    expect(page).to have_content("Congrats! You're one step away from making your dashboard public.")
    #expect(page).to have_content('You’re about to make this dashboard accessible by the public.')
    
    #page.save_screenshot('screenshot_step_3.png')
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "Enable the checkbox for 'I understand and accept the risks.' THEN select the PUBLISH NOW button",
      response: "Does a popup/dialog (Link Published) appear containing the link?" do
    
    # *** START EDITING HERE ***

    # action
    page.check('confirm-publish-link')
    page.click_link_or_button('Publish Now')

    # response
    expect(page).to have_content('Link Published')

    #page.save_screenshot('screenshot_step_4.png')
    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "Select COPY LINK , ( IF you get prompted to allow access to your clipboard ... allow access), "\
              " and then click on FINISHED button",
      response: "Does the pop up or the dialog disappear?" do
   
    # *** START EDITING HERE ***
	   
    # action
    link_text = page.find(:css, '.textfield.auto-linkpublished-textfield')['value']
    page.click_link_or_button('Finished')

    # response
    expect(page).to have_no_content('Link Published')

    #page.save_screenshot('screenshot_step_5.png')
    # *** STOP EDITING HERE ***
  end

  step id: 6,
    action: "Click on 'Published Links' tab, click on tab's 3 dots (hamburger menu) > Share > Manage Published links to dashboard...",
    response: "Do you see a published link on the page?" do
      
    # *** START EDITING HERE ***
      
    # action
    page.find(:css, 'li', :text => 'Published Links').click
    page.find(:css, '.three-dots').click
    page.find(:css, '#menuitem-share_tab').hover
    page.find(:css, '#menuitem-manage_published_tabs').click

    # response 
    expect(page).to have_content('my link')

    #page.save_screenshot('screenshot_step_6.png')
    # *** STOP EDITING HERE ***
  end
  
  
 step id: 7,
      action: "Click on 'my link'",
      response: "Do you see a new dialog or a pop up (Edit Published Link to Dashboard) ?" do

    # *** START EDITING HERE ***

    # action
    page.find(:css, 'span', :text => 'my link', :match => :first).click

    # response
    expect(page).to have_content('Edit Published Link to Dashboard')
    
    #page.save_screenshot('screenshot_step_7.png')
    # *** STOP EDITING HERE ***

  end

  step id: 8,
      action: "Set the Visibility to 'Anyone with the link and password', and set the password as '12345', click on FINISHED button",
      response: "Do you see the visibility of the published link as 'Anyone with link and password' on the page?" do
    # *** START EDITING HERE ***
    
    # action
    page.choose('Anyone with the link and password')
    page.fill_in 'password', with: '12345'
    page.click_link_or_button('Finished')

    # response
    within(:css, '#admin-pane') do
      expect(page).to have_content('Anyone with link and password')
    end

    #page.save_screenshot('screenshot_step_8.png')
    # *** STOP EDITING HERE ***

  end
  
  step id: 9,
      action: "Paste the URL to the dashboard, which you had copied earlier, into the browser address bar and press enter."\
              " After the link is opened screenshot.png enter a wrong password: '54321' and click on GO",
      response: "Do you see the proper error message?" do

    # *** START EDITING HERE ***
    
     # action
     visit link_text
     expect(page).to have_content('Password Required')
     page.fill_in 'password', with: '54321'
     page.find(:css, "input[value='Go']").click

    # response
    expect(page).to have_content('The password you entered is invalid.')


    #page.save_screenshot('screenshot_step_9.png')
    # *** STOP EDITING HERE ***

  end

  
  step id: 10,
      action: "Now enter the above (correct) password you just set ('12345') and click on GO",
      response: "Do you see the dashboard now?" do

    # *** START EDITING HERE ***

    # action
    page.fill_in 'password', with: ''
    page.fill_in 'password', with: '12345'
    sleep(1)
    page.find(:css, "input[value='Go']").click

    # response
    expect(page).to have_content('my link')

    #page.save_screenshot('screenshot_step_10.png')
    # *** STOP EDITING HERE ***

  end

  #sleep(10)

end
