import json
import subprocess

with open("applications.json") as file:
    applications = json.load(file)

schema = "org.gnome.settings-daemon.plugins.media-keys"
paths = [
    f"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom{i}/"
    for i in range(len(applications))
]
subprocess.run(["/bin/gsettings", "set", schema, "custom-keybindings", str(paths)])
for path, (wm_class, app, key) in zip(paths, applications):
    tmp = ["/bin/gsettings", "set", f"{schema}.custom-keybinding:{path}"]
    subprocess.run(tmp + ["name", wm_class])
    subprocess.run(tmp + ["command", f"focus-application {wm_class} {app}"])
    subprocess.run(tmp + ["binding", f"<Super>{key}"])
