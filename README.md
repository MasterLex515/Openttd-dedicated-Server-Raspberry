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

