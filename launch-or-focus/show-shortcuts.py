import json

with open("applications.json") as file:
    applications = json.load(file)

print(
    """
 1. Make "launch-or-focus" is executable!
 2. Make sure wmctrl and xdotool are installed.
 3. Set these commands as custom keyboard shortcuts:
    System Settings > Keyboard > Shortcuts > Custom Shortcut
    e.g. Shift+Super+T to open Terminal and Super+T to focus Terminal

    close current application: xdotool key --master getactivewindow --clearmodifiers alt+F4
"""
)

for wm_class, program_path, _ in applications:
    print(f"open : {program_path}" f"focus: launch-or-focus {wm_class} {program_path}")
