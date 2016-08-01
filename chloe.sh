#!/bin/bash

##### [START] Variables
LOG_FILE="/tmp/chloe.log"

##### [START] Functions
timestamp(){
	date +"%T"
}

Log(){
	mkdir /tmp
}

Stats(){
	echo -e "Getting local IP Address\n" && echo $( date +"%m/%d/%Y_%H:%M:%S" ) >> $LOG_FILE
	echo "Start Time: " $( date +"%m/%d/%Y_%H:%M:%S" )
	ipconfig getifaddr en0
	ipconfig getifaddr en1
	echo "End Time: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "Executing command: sysctl -n machdep.cpu.brand_string\n" && echo $( date +"%m/%d/%Y_%H:%M:%S" ) >> $LOG_FILE
	echo "Start Time: " $( date +"%m/%d/%Y_%H:%M:%S" )
	sysctl -n machdep.cpu.brand_string
	echo "End Time: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "Executing command: system_profiler\n\n" && echo $( date +"%m/%d/%Y_%H:%M:%S" ) >> $LOG_FILE
	echo "Start Time: " $( date +"%m/%d/%Y_%H:%M:%S" ) 
	system_profiler
	echo "End Time: " $( date +"%m/%d/%Y_%H:%M:%S" )
}

Prep(){
	clear # clear the screen
	echo -e "Preparing machine...\n" && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Preparing machine..." >> $LOG_FILE
	echo "Start Time: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "\n** [START] Adjusting Terminal: " $( date +"%m/%d/%Y_%H:%M:%S" )
	echo -e "** [END] Adjusting Terminal: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "\n** [START] Setting System Preferences: " $( date +"%m/%d/%Y_%H:%M:%S" )
	echo -e ny031c7d | sudo -S systemsetup -settimezone America/New_York && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " set timezone: America/New_York" >> $LOG_FILE

	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.driver.AppleBluetoothMultitouch.trackpad set" >> $LOG_FILE
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.mouse.tapBehavior set" >> $LOG_FILE
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 
	defaults -currentHost write ~/Library/Preferences/.GlobalPreferences com.apple.swipescrolldirection -bool false && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.swipescrolldirection set" >> $LOG_FILE
	defaults write com.apple.menuextra.battery ShowPercent -string "YES" && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.menuextra.battery ShowPercent set" >> $LOG_FILE
	defaults write com.apple.menuextra.battery ShowTime -string "YES" && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.menuextra.battery ShowTime set" >> $LOG_FILE
	defaults write com.apple.finder EmptyTrashSecurely -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.finder EmptyTrashSecurely set" >> $LOG_FILE
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.NetworkBrowser BrowseAllInterfaces set" >> $LOG_FILE
	defaults write com.apple.iCal IncludeDebugMenu -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.iCal IncludeDebugMenu set" >> $LOG_FILE
	defaults write com.apple.LaunchServices LSQuarantine -bool NO && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.LaunchServices LSQuarantine set" >> $LOG_FILE
	defaults write com.apple.screencapture location -string "$HOME/Desktop" && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.screencapture location set" >> $LOG_FILE
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.Safari IncludeInternalDebugMenu set" >> $LOG_FILE
	defaults write com.apple.Safari IncludeDevelopMenu -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.Safari IncludeDevelopMenu set" >> $LOG_FILE
	defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey set" >> $LOG_FILE
	defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled set" >> $LOG_FILE
	defaults write NSGlobalDomain WebKitDeveloperExtras -bool true && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " NSGlobalDomain WebKitDeveloperExtras set" >> $LOG_FILE
	defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }' && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.dock recent-items set" >> $LOG_FILE
	defaults write com.apple.dock static-only -bool TRUE; killall Dock && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " com.apple.dock static-only set" >> $LOG_FILE
	echo -e "** [END] Setting System Preferences: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "\n** [START] Installing Homebrew: " $( date +"%m/%d/%Y_%H:%M:%S" )
	xcode-select --install && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " xcode command line tools installed" >> $LOG_FILE 
	# Xcode license acceptance | https://raw.githubusercontent.com/pivotalservices/sprout-wrap-pivotal/master/install.sh
	curl -Ls https://raw.githubusercontent.com/pivotalservices/sprout-wrap-pivotal/master/scripts/accept-xcode-license.exp > accept-xcode-license.exp
	if [ -x "$(which expect)" ]; then
		echo "By using this script, you automatically accept the Xcode License agreement found here: http://www.apple.com/legal/sla/docs/xcode.pdf"
		expect ./accept-xcode-license.exp 
	else
		echo -e "\x1b[31;1mERROR:\x1b[0m Could not find expect utility (is '$(which expect)' executable?)"
		echo -e "\x1b[31;1mWarning:\x1b[0m You have not agreed to the Xcode license.\nBuilds will fail! Agree to the license by opening Xcode.app or running:\n
			xcodebuild -license\n\nOR for system-wide acceptance\n
			sudo xcodebuild -license" 
		exit 1
	fi
	
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " homebrew installed" >> $LOG_FILE 
	brew doctor && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " homebrew verified" >> $LOG_FILE
	echo -e "** [END] Installing Homebrew: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Updated & Upgraded Homebrew: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew update && brew upgrade >> $LOG_FILE
	echo -e "** [END] Updated & Upgraded Homebrew: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Remove outdated versions from the cellar: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cleanup
	echo -e "** [END] Remove outdated versions from the cellar: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Installing 1Password: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install 1password && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: 1Password" >> $LOG_FILE
	echo -e "** [END] Installing 1Password: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing Google Chrome: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install google-chrome && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Google Chrome" >> $LOG_FILE
	echo -e "** [END] Installing Google Chrome: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing Mozilla Firefox: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install firefox && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Mozilla Firefox" >> $LOG_FILE
	echo -e "** [END] Installing Mozilla Firefox: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Installing Opera: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install opera && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Opera" >> $LOG_FILE
	echo -e "** [END] Installing Opera: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing Skype: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install skype && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Skype" >> $LOG_FILE
	echo -e "** [END] Installing Skype: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing Teamviewer: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install teamviewer && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Teamviewer" >> $LOG_FILE
	echo -e "** [END] Installing Teamviewer: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing Spotify: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install spotify && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Spotify" >> $LOG_FILE
	echo -e "** [END] Installing Spotify: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing VLC: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install vlc && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: VLC" >> $LOG_FILE
	echo -e "** [END] Installing VLC: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing Git: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew install git && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Git" >> $LOG_FILE
	echo -e "** [END] Installing Git: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Installing uTorrent: " $( date +"%m/%d/%Y_%H:%M:%S" )
	echo -e "ny031c7d" | brew cask install utorrent && open /opt/homebrew-cask/Caskroom/utorrent/latest/uTorrent.app && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: uTorrent" >> $LOG_FILE
	echo -e "** [END] Installing uTorrent: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing Evernote: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install evernote && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Evernote" >> $LOG_FILE
	echo -e "** [END] Installing Evernote: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Installing MAMP: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew cask install mamp && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: MAMP" >> $LOG_FILE
	echo -e "** [END] Installing MAMP: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Installing wget: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew install wget && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: wget" >> $LOG_FILE
	echo -e "** [END] Installing wget: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Installing ssh-copy-id: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew install ssh-copy-id && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: SSH-COPY-ID" >> $LOG_FILE
	echo -e "** [END] Installing ssh-copy-id: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing Java: " $( date +"%m/%d/%Y_%H:%M:%S" )
	echo -e "ny031c7d" | brew cask install java && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: Java" >> $LOG_FILE
	echo -e "** [END] Installing Java: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing more recent versions of some OS X tools: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew install vim –override-system-vi && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: VIM" >> $LOG_FILE
	brew install homebrew/dupes/grep && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: GREP" >> $LOG_FILE
	brew install homebrew/dupes/screen && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: SCREEN" >> $LOG_FILE
	echo -e "** [END] Installing more recent versions of some OS X tools: " $( date +"%m/%d/%Y_%H:%M:%S" )
	
	echo -e "** [START] Installing more useful tools: " $( date +"%m/%d/%Y_%H:%M:%S" )
	brew install git bash-completion && echo $( date +"%m/%d/%Y_%H:%M:%S" ) " Installing: GIT-BASH-COMPLETION" >> $LOG_FILE
	echo -e "** [END] Installing more useful tools: " $( date +"%m/%d/%Y_%H:%M:%S" )

	echo -e "** [START] Set wallpaper: " $( date +"%m/%d/%Y_%H:%M:%S" )
	wget http://fanboygalaxy.com/wp-content/uploads/2016/02/114251.jpg && mv 114251.jpg ~/Pictures/114251.jpg

	osascript -e 'tell application "Finder" to set desktop picture to "/Users/saiyan/Pictures/114251.jpg" as POSIX file'
	echo -e "** [END] Set wallpaper: " $( date +"%m/%d/%Y_%H:%M:%S" )
	echo -e "\nDone. Note that some of these changes require a logout/restart to take effect.\n"
}

##### [START] Main logic
echo -e "\nHey D, what can I do for you?"
echo "Here are your choices:"
echo -e "\n\n1) Prep new your mac\n2) Display current machine stats\n3) Initiate factory restore\n"
echo -n "> "

if read -t 30 choice; then
    if [ $choice -eq 1 ]
    then
	Log
    	Prep
	echo -e ny031c7d | sudo shutdown -r now
    elif [ $choice -eq 2 ]
    then
	Log
    	Stats
    elif [ $choice -eq 3 ]
    then
	Log
    	FactoryRestore
    else
    	echo -e "Sorry D, I don't have the capability to perform that task yet...\n"
    fi
else
    echo "Okay, talk to you later..."
    exit 1
fi


##### [START] Comments
# https://www.learningosx.com/101-ways-to-tweak-os-x-using-terminal/
