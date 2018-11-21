# KVV Abfahrtsmonitor
forked from https://github.com/fablab-ka/kvvliveapi
which is based on https://github.com/Nervengift/kvvliveapi

Zeigt die Abfahrtszeiten von KVV-Straßenbahnen an.

## Installation (Linux/Ubuntu)
* Git-Verzeichnis herunterladen: `git clone https://github.com/fablab-ka/kvvliveapi.git`
* Nginx Companion installieren
* Bottle installieren: `sudo apt-get install python-bottle`
* `python app.py` ausführen.
* Webbrowser öffnen und 127.0.0.1:8080 eingeben.
* Nach Stationsnamen suchen
* Auf den Link neben dem Namen klicken
* Nicht mehr die Bahn verpassen

## Installation (Docker)
* docker-compose installieren
* Git-Verzeichnis herunterladen: `git clone https://github.com/fablab-ka/kvvliveapi.git`
* nginx/letsencrypt Comapion laden und konfigurieren: https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion
* `docker-compose up -d`

#### Einrichten eines KVV-Infomonitors mit Chromium
* Chromium installieren: `sudo apt-get install chromium-browser`
* Chromium automatisch starten: `nano .config/autostart/Chromium KVV-Info.desktop`
```bash
[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=Chromium KVV-Info
Comment=
Exec=/usr/bin/chromium-browser --password-store=basic --incognito --no-first-run --touch-events=enabled --fast --fast-start --disable-popup-blocking --disable-infobars --disable-session-crashed-bubble --disable-tab-switcher --disable-translate --enable-low-res-tiling --kiosk 127.0.0.1:8080/kvv_table?station=de:8212:1
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false
```
## Bilder
#### Suchen von Stationen
![kvv_search](https://github.com/fablab-ka/kvvliveapi/blob/master/docs/kvv_search.png)
#### Anzeigen der Abfahrtszeiten
![kvv_table](https://github.com/fablab-ka/kvvliveapi/blob/master/docs/kvv_table.png)
=======
# kvvliveapi

`pip install kvvliveapi`

Python Bindings für die API, die von der KVV Live Webapp benutzt wird.

Wenn jemand bindings für andere Sprachen schreiben will: hier die Dokumentation der API. Andere bindings würde ich auch gerne hier verlinken :)

Andere Sprachen und Anwendungen:

* [Bindings für PHP](https://github.com/MartinLoeper/KVV-PHP-unofficial-)
* [Bindings für Rust](https://github.com/nervengift/kvvliveapi-rs) (auch von mir)
* [Bindings für Ruby](https://github.com/julianschuh/kvvliveapi)
* [Eine Shopify Dashing Beispielumsetzung](https://github.com/anthu/kvv-departure-dashboard)
* [Ein Modul für den MagicMirror²](https://github.com/yo-less/MMM-KVV)

# API Dokumentation

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

