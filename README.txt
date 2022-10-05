One time configuration

* Copy   config.bat  to create a new file    config_local.bat
* Inside  config_local.bat   set PIXELMANDIR to the directory where the pixelman.exe you wish to use resides.
  The existing setting will use the version in the "vendor" directory shipped with this kit. 
  You also need to set PIXDET to the appropriate detector type 
* You then need to edit MpxManager.ini in the above specified PIXELMANDIR directory and add the line    plugins\epics.dll   to the [plugins] section

Running pixelman

* For process variables to be visible outide the camera PC, you need to either have an EPICS gateway running or change the EPICS_CAS_INTF_ADDR_LIST in run_pixelman.bat
* If using a gateway, make sure gateway access security file in instrument/settings area is appropriate
* run either   run_pixelman.bat   or   run_jpixelman.bat   in this directory (these copy the  epics.dll  across to the plugins area of PIXELMANDIR)
* process variables as described in  pixelman.db  will get created

Configuring for dummy detector/hardware library

* you need to copy the file  dummy_2000.txt to same directory as the pixelman.exe executable (PIXELMANDIR)
* you need to type the string   dummy_2000.txt    into     Options -> Device settings -> Interface specific info -> data directory or first data file name    in pixelman GUI. 
  For some reason, selecting this input box can take some time - it looks like maybe a "triple click" is required.
* you may also need to move/rename the file   hwlibs/mpxHwSample.dll   as if it is loaded when the detector is not present it can cause a crash (the one shipped in "vendor" has this done)
* make sure your config_local.bat defines "dummy" as the PIXDET

General Notes

run_pixelman.bat runs  pixelman.exe whihc loads epics.dll as a plugin, which in turn starts an epics IOC.
The IOC will load commands from  pixelman.cmd   which can be adjusted as appropriate. It will load EPICS db
files and then start the IOC. See pixelman.db for a list of PVs.

The IOC is linked against the EPICS autosave, caPutLog and sequencer modules. Some autosaveFields info record 
are defined in pixelman.db

As mentioned earlier, writing to a PV writes directly to pixelman and so is not currently reflected in the GUI

See FitsParameters.db for available fits parameters that can be set via PVs

The PV prefix at ISIS is taken from the MYPVPREFIX environment variable, but this can be changed in pixelman.cmd
The default is to use PC name and user name, this is echoed to screen when  run_pixelman is started

Demo

Executing an unmodified run_pixelman.cmd will:
* start pixelman GUI
* Create PVs bound to the loopback interface with a host:user prefix

You can then type something like:

    set EPICS_CA_ADDR_LIST=127.255.255.255
    camonitor NDW1548:FAA59:PIXELMAN:ACQ:FF

to see frames filled. If you then configure the dummy detector and start acquisition from the GUI, you should see this value increase.

Though run_pixelman.bat runs the normal pixelman and is best for production use, I have found run_jpixelman useful for 
ioc startup debugging as more output appears on the screen
 
We would normally have the distribution installed at C:\Instrument\Apps\EPICS32\support\pixelman\master\...   but it should work from elsewhere

An illustrative control script is included in   example_script.py
