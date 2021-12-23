# Usage: script ARG1 ARG2
#  ARG1: WM_CLASS of application
#  ARG2: /path/to/application
# Description: Use this script to create a keyboard shortcut to focus an application.
#  Case A: application is not running           --> open a new instance
#  Case B: application is running without focus --> focus instance with highest z-index
#  Case C: application is running and has focus --> focus another instance (lowest z-index)

class_ids=$(xdotool search --onlyvisible --classname "$1" \
          | head -n "$(wmctrl -lx | awk '{ print $3 }' | grep "$1" -c)" || :)

if [ -z "$class_ids" ] ; then
    # Case A
    echo launch!!
    $2 & disown
else
    echo no launch!!
    current_id=$(xdotool getactivewindow)
    if echo "$class_ids" | !grep -q "$current_id" ; then
        # Case B
        new_id=$(echo "$class_ids" | awk '{ print $NF}')
    else
        # Case C
        new_id=$(echo "$class_ids" | awk '{ print $1}')
    fi

    xdotool windowactivate "$new_id"
fi
