# Rainforest Klipfolio Automation

## Prerequisites

These instructions assume you have the following installed on your machine:

1. [Firefox](http://www.mozilla.org/en-US/firefox/new/)

## SETUP for Mac OSX

All of the following assume that they are not already installed. You can skip any that are already installed.


### Install Command Line Tools:

In a terminal type the following command: 
```bash
xcode-select --install
```
You should see a pop up saying that “xcode-select” requires the command line developer tools. Click Install
You will have to accept the license agreement


### Install Homebrew:

You can get the latest command to install Homebrew from their website at https://brew.sh/
Alternatively you should be able to run the following command from a terminal:
```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
After installing run the command: 
```bash
brew doctor
```
This will test to make sure everything installed correctly


### Install Git

To install Git if it is not already installed, run the following commands from a terminal:
```bash
brew update
brew install git
```
To verify installation run: 
```bash
git —version
```
You will need to sign up for an account on github


### Clone the repository:

In a terminal run the following in the directory where you would like to clone the Rainforest Klipfolio automation repository:
```bash
git clone https://github.com/burbon000/rainforest_klipfolio_automation.git
cd rainforest_klipfolio_automation
```


### Install Ruby Version Manager(RVM) to manage your Ruby environments:

RVM is not a requirement, but if you do not want to use it, you will need to make sure that ruby version 2.3.3 is installed and first in the path.
```bash
curl -L https://get.rvm.io | bash -s stable
```
To verify installation, run: 
```bash
rvm -v
```
You must use version 2.3.3 of Ruby. To install version 2.3.3 of Ruby, run the following:
```bash
rvm install 2.3.3
```
If you have multiple versions of Ruby installed, RVM will automatically detect the version of Ruby used by an application based on the Gemfile.


### Finally you must install the dependencies:

```bash
gem install bundler
bundle install
brew install geckodriver
```

----------------------------------END of Mac OSX Setup-----------------------------
## SETUP for Windows 7

### Install Git

Using a browser, download the latest version of git for windows from https://git-for-windows.github.io

To verify installation, open a command prompt(cmd.exe) run: 
```bash
git —version
```
You will need to sign up for an account on github


### Clone the repository:

From the command prompt run the following in the directory where you would like to clone the Rainforest Klipfolio automation repository:
```bash
git clone https://github.com/burbon000/rainforest_klipfolio_automation.git
cd rainforest_bbm_automation
```


### Install Ruby version 2.3.3-p222 and Ruby devkit:

In a browser go to RubyInstaller.org https://rubyinstaller.org/downloads/
Install Ruby 2.3.3 for your operating system Ruby 2.3.3 (x64) if it is 64 bit, or Ruby 2.3.3 if it is 32bit
Allow the installation to put Ruby in your path unless you want to add it manually
To verify the installation, open a command prompt and type:
```bash
ruby --version
```
You should see 2.3.3-p222
From the same browser window install Development Kit (select the version for Ruby 2.3 with the correct operating system)



### Install geckodriver: 

In a browser go to https://github.com/mozilla/geckodriver/releases
Install v0.19.1
This entails downloading the zip file for version v0.19.1, and unzipping it (it is just a single file) into a folder in your path. You can also unzip it to a new folder and add that folder to your path. 


### Finally you must install the dependencies:

From a new command prompt (cmd.exe) run the following:
```bash
gem install bundler
bundle install
```
----------------------------------END of Windows 7 Setup-----------------------------

## Running the tests

### Locally:
```bash
bundle exec rainforest_test test_case.rb
```
### Sauce Labs:
To run on Sauce Labs, you first need to set the following environment variable. 
```bash
export CAPYBARA_DRIVER=sauce
```
In the script, you will need to specify your sauce_username and sauce_access_key in the variables provided.
Then to execute the scripts use the same command as running locally:
```bash
bundle exec rainforest_test test_case.rb
```


## Advance features


### Timeouts

By default, we have configured Capybara to timeout after 20 seconds. This can be a little long and annoying while developing. This value is configurable through an environment variable.

```bash
CAPYBARA_WAIT_TIME=1 bundle exec rainforest_test test_case.rb
```


## Help!

If you find a bug with this, please email [qe@rainforestqa.com](mailto:qu@rainforestqa.com)
