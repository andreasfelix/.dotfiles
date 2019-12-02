# Usage: script ARG1 ARG2
#  ARG1: WM_CLASS of application
#  ARG2: /path/to/application
# Description: Use this script to create a keyboard shortcut to focus an application.
#  Case 1: application is not running           --> open a new instance
#  Case 2: application is running without focus --> focus instance with highest z-index
#  Case 3: application is running and has focus --> focus another instance (lowest z-index)

class_ids=$(xdotool search --onlyvisible --classname $1 | head -n "$(wmctrl -lx | awk '{ print $3 }' | grep $1 -c)")
if [ -z "$class_ids" ] ; then # case 1
    $2 &
else
    current_id=$(xdotool getactivewindow)
    if [ -z "$(echo $class_ids | grep $current_id)" ]; then # case 2
        new_id=$(echo $class_ids | awk '{ print $NF}')
    else # case 3
        new_id=$(echo $class_ids | awk '{ print $1}')
    fi
    xdotool windowactivate "$new_id"
fi
