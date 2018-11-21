#!/bin/bash
python3 app.py&
startx -- -nocursor
killall python3
