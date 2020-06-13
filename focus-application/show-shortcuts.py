import json

with open("applications.json") as file:
    applications = json.load(file)

print("""
 1. Make "focus-applications" is executable!
 2. Make sure wmctrl and xdotool are installed.
 3. Set these commands as custom keyboard shortcuts:
    System Settings > Keyboard > Shortcuts > Custom Shortcut
    e.g. Shift+Super+T to open Terminal and Super+T to focus Terminal

    close current application: xdotool key --master getactivewindow --clearmodifiers alt+F4
""")

for wm_class, program_path, _ in applications:
    print(
        f"open : {program_path}"
        f"focus: focus-application {wm_class} {program_path}"
    )

