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

    #station 1
    station1 = kvvliveapi.search_by_stop_id(stationId)[0]
    departures1 = kvvliveapi.get_departures(station1.stop_id, max_info=maxLines)
    departures1 = [dep for dep in departures1 if dep.route != 'E'] #filter out stuff
    departures11 = [dep for dep in departures1 if dep.stopPosition == '1']
    departures12 = [dep for dep in departures1 if dep.stopPosition == '2']  

    #station 2
    station2 = kvvliveapi.search_by_stop_id(station2Id)[0]
    departures2 = kvvliveapi.get_departures(station2.stop_id, max_info=maxLines)
    departures2 = [dep for dep in departures2 if dep.route != 'E'] #filter out stuff
    departures21 = [dep for dep in departures2 if dep.stopPosition == '1']
    departures22 = [dep for dep in departures2 if dep.stopPosition == '2']  

    time = datetime.datetime.now().strftime("%H:%M")

    return template('make_table', time=time, 
                    station1=station1.name, 
                    station2=station2.name,
                    rows11=departures11, 
                    rows12=departures12, 
                    rows21=departures21, 
                    rows22=departures22)


@app.route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='static/')

print("Starting web service!")
debug(True)
run(app, host='0.0.0.0', port=8088)
