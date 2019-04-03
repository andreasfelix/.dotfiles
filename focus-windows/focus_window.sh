# case 1: application is running         -> activate window
# case 2: multiple instances are running -> toggle focus
# case 3: application is not running     -> open application
# Arg1: WM_CLASS of application, Arg2: /dir_path/to/application

class_ids=$(xdotool search --onlyvisible --classname $1 | head -n "$(wmctrl -lx | awk '{ print $3 }' | grep $1 -c)")
if [ -n "$class_ids" ] ; then
    current_id=$(xdotool getactivewindow)
    if [ -z "$(echo $class_ids | grep $current_id)" ]; then
        echo case 1
        new_id=$(echo $class_ids | awk '{ print $NF}')
    else
        echo case 2
        new_id=$(echo $class_ids | awk '{ print $1}')
    fi
    xdotool windowactivate "$new_id"
else
    echo case 3
    $2 &
fi
