# Focus Application
Use `focus-application.sh` to create a keyboard shortcut which focuses an application. The script behaves in that way that if ..

- **Case 1**: ... the application is not running, it opens a new instance.
- **Case 2**: ... the application is running but is not focused, it focuses the instance with highest z-index.
- **Case 3**: ... the application is running and has focus, it focuses another instance (lowest z-index).

## Install dependencies
The the depends on xdotool and wmctrl, which can be installed with:

`apt install xdotool wmctrl`

## Usage
The shell script `focus-application.sh` takes to input arguments:
1. The WM\_class of the application.
2. The command which invokes the application.

Run the script:

`./focus-application.sh <WM_class of application> /path/to/application`

Don't forget to make the scirpt executable before (`chmod +x script`).

## Set Keyboard Shortcuts
### Create commands manually

1. Find out the WM\_class of the application by running the following command 

   `xprop WM_CLASS | awk {'print $3'}` 
   
   and clicking on the window.
   
2. Set custom a keyboard shortcut in *System Settings > Keyboard > Shortcuts > Custom Shortcut*.

   `/path/to/focus-application.sh $WM_CLASS $COMMAND`

### For multiple commands use print\_commands.py
To make this a bit easier for multiple commands, you can use the `print_commands.py` Python script.

1. Fill out the `applications.json` file with the application you want to assign a keyboard shortcut to. The frist argument is `WM_CLASS` and the second one is the command which invokes the Application.
2. Run the Python script with: 

   `python3 print_commands.py`

3. The script outputs a list of commands. Copy and paste them to *Settings > Keyboard > Shortcuts > Custom Shortcut*.
 


