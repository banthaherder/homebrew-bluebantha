install: install-deps install-script install-daemon

reinstall: reinstall-script reinstall-daemon

install-deps:
	@echo "Installing dependencies..."
	@brew install blueutil jq

install-script:	
	@echo "Installing script..."
	@sudo cp ./src/bluebantha.sh /usr/local/bin/bluebantha.sh

install-daemon:
	@echo "Unpacking daemon..."
	@sudo cp com.banthabot.bluebantha.plist /Library/LaunchDaemons/com.banthabot.bluebantha.plist
	@sudo launchctl load -F -w /Library/LaunchDaemons/com.banthabot.bluebantha.plist
	@echo "Install complete!"

reinstall-script: install-script
reinstall-daemon:
	@echo "Cleaning daemon..."
	@sudo launchctl stop com.banthabot.bluebantha.plist || true
	@sudo launchctl remove com.banthabot.bluebantha.plist || true
	@echo "Reinstalling daemon..."
	@sudo cp com.banthabot.bluebantha.plist /Library/LaunchDaemons/com.banthabot.bluebantha.plist
	@sudo launchctl load -F -w /Library/LaunchDaemons/com.banthabot.bluebantha.plist
	@echo "Install complete!"
