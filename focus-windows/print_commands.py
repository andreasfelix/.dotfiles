import json, os

with open('applications.json', 'r') as fh:
    applications = json.load(fh)

base_dir = os.path.dirname(os.path.abspath(__file__))
script_name = 'focus_window.sh'

print("""
 1. Make focus_window.sh executable!
 2. Make sure xdotool is installed.
 3. Set these commands as custom keyboard shortcuts:
    System Settings > Keyboard > Shortcuts > Custom Shortcut
    e.g. Shift+Super+T to open Terminal and Super+T to focus Terminal

    close current application: xdotool key --master getactivewindow --clearmodifiers alt+F4
""")

for wm_class, program_path in applications:
    print(f"""\
    open : {program_path}
    focus: {base_dir}/{script_name} {wm_class} {program_path}
    """)

