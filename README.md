# KVV Abfahrtsmonitor
forked von https://github.com/Nervengift/kvvliveapi

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
