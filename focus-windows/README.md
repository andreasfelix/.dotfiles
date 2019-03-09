# Focus windows 
The shell script `focus_window.sh` can be used to create a keyboard shortcut to switch focus to a specific application.

- **Case 1**: If the application is running, the script will focus the application.
- **Case 2**: If the application is not running, the script will open the application.
- **Case 3**: If multiple instances of the applications are running the script switches focus between them.

## Install dependencies
The Script uses xdotool and wmctrl.

`apt install xdotool wmctrl`

## Usage

The shell script `focus_window.sh` takes to input arguments:
1. The WM\_class of the application.
2. The command which invokes the application.

Run the script:

`./focus_window.sh <WM_class of application> /path/to/application`

## Set Keyboard Shortcuts
### Create commands manually

1. Find out the WM\_class of the application by running the following command 

   `xprop WM_CLASS | awk {'print $3'}` 
   
   and clicking on the window.
   
2. Set custom a keyboard shortcut in *System Settings > Keyboard > Shortcuts > Custom Shortcut*.

   `/path/to/focus_window.sh $WM_CLASS $COMMAND`

### For multiple commands use print\_commands.py
To make this a bit easier for multiple commands, you can use the `print_commands.py` Python script.

1. Fill out the `applications.json` file with the application you want to assign a keyboard shortcut to. The frist argument is `WM_CLASS` and the second one is the command which invokes the Application.
2. Run the Python script with: 

   `python3 print_commands.py`

3. The script outputs a list of commands. Copy and paste them to *Settings > Keyboard > Shortcuts > Custom Shortcut*.
 


