FILE=/sys/module/hid_apple/parameters/fnmode
FNMODE = $(shell cat ${FILE})

install:
	# Install the script
	mkdir -p ~/bin
	cp ./src/fn-*.sh ~/bin/
	chmod +x ~/bin/fn-*.sh

	# Install the icons
	xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-lock.png fn-lock
	xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-unlock.png fn-unlock

	# Install the Launchers
	xdg-desktop-menu install ./src/fn-lock.desktop
	xdg-desktop-menu install ./src/fn-unlock.desktop	

	# Install the autostart Lancher
	cp ./src/fn-autostart.desktop $(HOME)/.config/autostart/

	# Rename the launcher
ifeq ($(findstring 0,$(FNMODE)),0)
	@echo FNMODE value is 0
	sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fn-unlock.desktop
endif
ifeq ($(findstring 1,$(FNMODE)),1)
	@echo FNMODE value is 1
	sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fn-lock.desktop
endif
ifeq ($(findstring 2,$(FNMODE)),2)
	@echo FNMODE value is 2
	sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fn-unlock.desktop
endif
	
	# Update application menu list
	xdg-desktop-menu forceupdate
	
uninstall:
	xdg-desktop-menu uninstall fn-*.desktop
