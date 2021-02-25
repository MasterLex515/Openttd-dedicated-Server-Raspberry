# Openttd-Server-Raspberry

**02/2021**

This is how I installed a dedicated OpenTTD-Server (**v1.10.3**) on a Raspberry Pi.
The Base of this are the instructions from **[Tobias Schwarz](https://www.tobias-schwarz.com/en/posts/4/)**
### -
### Download, Compile and Install
#### Open a Shell

Login as the default pi user using SSH or if you do this from within the desktop just start the terminal. Make sure you are in your home directory:

```cd ~```

#### Download the Source-Code

```wget https://cdn.openttd.org/openttd-releases/1.10.3/openttd-1.10.3-source.tar.xz```

#### Extract the Source-Code

```tar -xvf openttd-1.10.3-source.tar.xz```

#### Install Dependencies for Compiling OpenTTD

```sudo apt-get update```

```sudo apt-get install build-essential pkg-config libsdl1.2-dev subversion patch zlib1g-dev liblzo2-dev liblzma-dev libfontconfig-dev libicu-dev```

#### Compile OpenTTD as dedicated server

```cd openttd-1.10.3/```

```./configure --enable-dedicated```

```make --jobs=4```

On multicore systems like the Raspberry Pi 2 and Raspberry Pi 3 you should use multiple threads to compile faster. Under Linux the number of logical cores can be obtained using:

```getconf _NPROCESSORS_ONLN```

#### Install the OpenTTD binary

```sudo make install```

#### Install OpenGFX graphics set

```wget https://cdn.openttd.org/opengfx-releases/0.6.0/opengfx-0.6.0-all.zip```

```unzip opengfx-0.6.0-all.zip```

```mv opengfx-0.6.0.tar .openttd/baseset```

Note: If you don’t install a graphics set at this point the server won’t start!

#### Create a config file for the OpenTTD server

To create a config file I just created an empty config file and started and stopped the OpenTTD server to fill it with the default values:

```touch ~/.openttd/openttd.cfg```

```openttd -D```

```exit```

Afterwards the config file can be edited

```nano ~/.openttd/openttd.cfg```

There is a [documentation for the openttd.cfg](https://wiki.openttd.org/en/Archive/Manual/Settings/Openttd.cfg) settings in the OpenTTD wiki.

### Automatically start the server
#### Set Reboot-Cronjob

I also want to automatically start the server but the mentioned 'OpenTTD init-script' from **Frode Woldsund** is not available anymore at bitbucket.org.
So here is a solution suitable for my private server:

My Raspberry Pi performs a reboot every 12 hours via manually set cronjobs.

The reboot needs '**sudo**'-permissions so the cronjobs for rebooting are added to the 'root-crontab'.

```sudo crontab -e```

(Location of this cron-file: ```/var/spool/cron/crontabs/root``` 'root' is the cron-file.)

#### Start-Script

I wrote my own start-script for the server which also loads the latest autosave: **startopenttdserver.sh**
I put the script in the pi home directory ```/home/pi/startopenttdserver.sh```

Make the script executable:

```chmod +x /home/pi/startopenttdserver.sh```

#### Install screen

**screen** is needed to run the start script. Install screen!

```sudo apt-get install screen```

#### Execute Script at reboot

Enter the reboot-order to the **crontab of user** pi. Type the command like above **without** sudo.

```crontab -e```

(Location of this cron-file: ```/var/spool/cron/crontabs/pi``` 'pi' is the cron-file.)

This creates/opens a seperate crontab-file.

Enter the following to that file:

```SHELL=/bin/bash```

```@reboot /bin/bash /home/pi/startopenttdserver.sh```

**Note:** The start-script can also be executed manually like any other shell-script.

**Note:** If you perform any changes to crontabs or the start-script you have to use **absolute paths**. Otherwise it won't work.

#### What does the script do?

The script creates a detached screen-terminal (name=openttd) to keep the server running when logging out from SSH.

The script executes the start-command in the openttd-screen.
The server boots and now in the openttd-screen the server-console is running.
The script navigates to the autosave directory and loads the latest autosave.
Between these steps the script waits a short interval so the Raspberry has time to perform the commands.

### Server Console

Use ```screen -ls``` to check whether a screen named 'openttd' exists.

Attach (view the server console) with ```screen -r openttd```

If the OpenTTD-Server is running the command ```screen -d```(for detaching) won't work. Then use the Keys: Ctrl+a d (Works also with *JuiceSSH*)

For an SSH connection via mobile phone I use [JuiceSSH](https://juicessh.com/)

**Before logging** out make sure that you are **detached** from the openttd-screen. Otherwise the server will stop at logout.
