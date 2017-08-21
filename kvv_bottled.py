import sqlite3
import kvvliveapi
import datetime
from bottle import Bottle, route, run, debug, template, static_file, request
import urllib2

app = Bottle()


@app.get('/kvv_search')
@app.get('/')
def kvv_search():
    formInfo = request.params
    if 'search_for' in formInfo and formInfo['search_for'] != "":
        stationList = kvvliveapi.search_by_name(formInfo['search_for'])
    else:
        stationList = None


    return template('search_stations', stations=stationList)


@app.route('/kvv_table')
def kvv_table():
    try:
        payload = request.params

        #setup parameters from payload
        if 'station' in payload:
            stationId = payload['station']
        else :
            stationId = 'de:8212:7' #Tullastrasse / VBK
        if 'entries' in payload:
            maxLines = payload['entries']
        else:
            maxLines = 10

        #get station
        stationList = kvvliveapi.search_by_stop_id(stationId)
        if len(stationList) == 0:
            return "Station " + str(stationId) + " was not found!"
        station = stationList[0]

        #get departures
        departures = kvvliveapi.get_departures(station.stop_id, max_info=maxLines)
        departures = [dep for dep in departures if dep.route != 'E'] #filter out stuff

        return template('make_table', rows=departures, station=station.name)
    except urllib2.HTTPError:
        print("HTTP Error!")
        return '<html><meta http-equiv="refresh" content="30"></html>'


@app.route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='static/')

run(app, host='0.0.0.0', port=8080)