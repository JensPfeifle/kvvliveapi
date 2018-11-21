import kvvliveapi
import datetime
from bottle import Bottle, route, run, debug, template, static_file, request

app = Bottle()
print("starting!")

@app.route('/kvv_table')
@app.get('/')
def kvv_table():

    stationId = 'de:8212:2' #Kronenplatz Kaiserstr
    station2Id = 'de:8212:80' # Kronenplatz Fritz-Erler Str
    maxLines = 10

    #get station
    stationList = kvvliveapi.search_by_stop_id(stationId)
    if len(stationList) == 0:
        return "Station " + str(stationId) + " was not found!"
    station1 = stationList[0]
    departures1 = kvvliveapi.get_departures(station1.stop_id, max_info=maxLines)
    departures1 = [dep for dep in departures1 if dep.route != 'E'] #filter out stuff

    stationList = kvvliveapi.search_by_stop_id(station2Id)
    if len(stationList) == 0:
        return "Station " + str(station2Id) + " was not found!"
    station2 = stationList[0]
    departures2 = kvvliveapi.get_departures(station2.stop_id, max_info=maxLines)
    departures2 = [dep for dep in departures2 if dep.route != 'E'] #filter out stuff

    time = datetime.datetime.now().strftime("%H:%M")

    return template('make_table', time=time, rows1=departures1, station1=station1.name, rows2=departures2, station2=station2.name)


@app.route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='static/')

print("Starting web service!")
debug(True)
run(app, host='0.0.0.0', port=8088)
