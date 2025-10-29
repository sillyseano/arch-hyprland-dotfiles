if pgrep -x "waypaper" > /dev/null; then
	waypaper_pid=$(pgrep -x "waypaper")
	waypaper_window=$(xdotool search --pid "waypaper_pid" 2>/dev/null | head -n 1)
	if [-n "$waypaper_window"]; then
		xdotool windowkill "$waypaper_window"
	else
		kill "$waypaper_pid"
	fi
else
	waypaper
fi
