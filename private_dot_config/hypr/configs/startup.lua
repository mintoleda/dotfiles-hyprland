-- Startup

hl.on("hyprland.start", function()
	-- hl.exec_cmd("waybar")
	-- hl.exec_cmd("quickshell")

	-- notifs
	hl.exec_cmd("mako --max-history 50")

	hl.exec_cmd("swww-daemon")
	hl.exec_cmd("copyq")
	hl.exec_cmd("foot --server")
	hl.exec_cmd("rog-control-center")

	-- idle management
	hl.exec_cmd("~/.config/hypr/scripts/idle.sh start")

	-- Wallpaper utils
	hl.exec_cmd(
		[[wallutils & waypaper --restore & sh -c 'wal -R -n || { wp=$(sed -n "s|^wallpaper = ||p" ~/.config/waypaper/config.ini); case $wp in "~"*) wp=$HOME${wp#"~"};; esac; wal -i "$wp" -n --cols16; }']]
	)
end)
