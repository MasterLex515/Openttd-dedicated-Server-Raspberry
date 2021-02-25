#!/bin/bash

echo ...
echo script startopenttdserver started.
echo ...
screen -dmS openttd
echo screen openttd created.
echo ... starting openttd-server.
screen -S openttd -X stuff '/home/pi/openttd-1.10.3/bin/openttd -D\n'
sleep 5s
echo openttd-server started.
echo ... loading last autosave.
screen -S openttd -X stuff 'cd save\n'
sleep 1s
screen -S openttd -X stuff 'cd autosave\n'
sleep 1s
screen -S openttd -X stuff 'load 1\n'
sleep 1s
screen -S openttd -X stuff 'echo ... autosave loaded ...\n'
sleep 1s
screen -S openttd -X stuff 'cd ..\n'
sleep 1s
screen -S openttd -X stuff 'cd ..\n'
echo last autosave loaded.
