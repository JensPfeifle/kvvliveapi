# KVV Abfahrtsmonitor
forked from https://github.com/fablab-ka/kvvliveapi which is based on https://github.com/Nervengift/kvvliveapi

[![Travis-Badge](https://travis-ci.com/JensPfeifle/kvvliveapi.svg?branch=master)](https://travis-ci.com/JensPfeifle/kvvliveapi)

Shows the departure times of KVV-trams. By default, the two stations Kronenplatz (Kaiserstr.) and Kronenplatz (Fritz-Erler-Str.) are watched.

## Installation (Linux/Ubuntu/Raspbian)
* Clone: `git clone https://github.com/JensPfeifle/kvvliveapi.git`
* Install bottle: `python3 -m pip install bottle`
* Run `python3 app.py`.
* Point a browser to 127.0.0.1:8088.
* Never miss your train again (if you need to get on at Kronenplatz...)

## Installation (Docker)
* Build image with `docker build -t kvvliveapi .` (the period is important!).
* Start the container with `docker run -p 80:8088 --name kvvliveapi kvvliveapi`.
* You can change port `80` to whatever you'd like.

  
## Setup a Rapsberry Pi to run in kiosk mode
* Start with Raspbian or Raspbian Lite
* Boot up start sudo raspi-config:
    * Change the user password!
    * Connect to a network.
    * Setup "Console Autologin"
    * (Enable SSH access)
    * Disable "Overscan" if the graphics don't fill the screen.
* Reboot, you should end up logged into a terminal session
* `sudo apt-get update` and `sudo apt-get upgrade`
* Make sure the following packages are installed:
    * `sudo apt-get install --no-install-recommends xserver-xorg x11-xserver-utils xinit openbox chromium-browser`
* Configure openbox:
``` # Disable any form of screen saver / screen blanking / power management
xset s off
xset s noblank
xset -dpms

# Allow quitting the X server with CTRL-ATL-Backspace
setxkbmap -option terminate:ctrl_alt_bksp

# Start Chromium in kiosk mode
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/chromium/'Local State'
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/; s/"exit_type":"[^"]\+"/"exit_type":"Normal"/' ~/.config/chromium/Default/Preferences
chromium-browser --disable-infobars --kiosk 'http://localhost:8088'
```
* Running `run_kioskmode.sh` should start openbox and load the app in chromium.
* When using the full version of Raspbian, you may need to set it up to start openbox: `echo "exec openbox-session" > ~/.xinitrc`. This may prevent your normal desktop environment from loading. Really, its best to use Raspbian Lite anyways.
* Quit with Ctrl-Alt-Backspace.

## Screenshots
#### Displaying the departure times for Kronenplatz
![kronenplatz](https://github.com/JensPfeifle/kvvliveapi/blob/develop/docs/kronenplatz.png)




# API Dokumentation

Python Bindings für die API, die von der KVV Live Webapp benutzt wird.

Install: `pip install kvvliveapi`


Für jeden Request muss der API-Key als GET-Parameter *key* mit übergeben werden. Der Schüssel ist 377d840e54b59adbe53608ba1aad70e8

Die url setzt sich zusammen aus *https://live.kvv.de/webapp/*, dann der Teil für die Anfrage, wie unten erklärt, dann noch ein *?key=API_KEY* (key s.o.)

## Suche

Die Suche liefert ein JSON-Objekt zurück, dass auf oberster Ebene nur das Attribut *stops* hat. Es enthält eine Liste von Haltestellen mit je den Attributen *id*, *name*, *lat* und *lon*)

### Suche nach Lat/Lon

Die Anfrage ist *API_BASE/stops/bylatlon/LAT/LON?key=API_KEY* (ersetze LAT und LON durch die gewünschten Werte)

### Suche nach Name

Die Anfrage ist *API_BASE/stops/byname/NAME?key=API_KEY* (ersetze NAME durch die gesuchten Haltestellennamen (url-Encoding nicht vergessen))

### Suche nach Haltestellen-ID

Die Anfrage ist *API_BASE/stops/bystop/HALTESTELLEN_ID?key=API_KEY* (ersetze HALTESTELLEN_ID durch die ID der gewünschten Haltestelle)

Diese Suche liefert nur das Haltestellen-JSON OHNE das Objekt mit dem *stops*-Attribut drum herum.


## Abfahrtszeiten

**ACHTUNG: hier gab es in letzer Zeit ein paar Änderungen und Attribute sind rausgeflogen. Insbesondere lässt sich die Nummer des Fahrzeugs nicht mehr herausfinden. Das Attribut *traction* wurde neu belegt!**

Das JSON hat auf der obersten Ebene die Attribute *timestamp*, *stopName* und *departures*. Letzeres enthält eine Liste von Abfahrten mit den Attributen *route* (Linie), *destination*, *direction* (1 oder 2), *time*, *lowfloor* (true oder false), *realtime* (ob Echtzeitwerte vorhanden sind), und *traction* (0 oder 2, Doppeltraktion???).

*direction* bezieht sich auf die Richtung der Linie, nicht der Haltestelle. Beispielsweise fahren an der Haltestelle Werderstraße Bahnen mit *direction*  1 oder 2 in Richtung Hauptbahnhof.

### Abfahrt nach Haltestelle

Die Anfrage ist *API_BASE/departures/bystop/HALTESTELLEN_ID?maxInfos=10&key=API_KEY* (ersetze HALTESTELLEN_ID durch die ID der gewünschten Haltestelle, *maxInfos* kann ebenfalls angepasst werden)

### Abfahrt nach Haltestelle und Linie

Die Anfrage ist *API_BASE/departures/byroute/LINIE/HALTESTELLEN_ID?maxInfos=10&key=API_KEY* (LINIE ist z.B. *S2*, Haltestelle wie oben)

