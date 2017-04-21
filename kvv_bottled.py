import sqlite3
import kvvliveapi
import datetime
from bottle import Bottle, route, run, debug, template, static_file

app = Bottle()

@app.route('/kvv_table')
def kvv_table():
    #print kvvliveapi.get_departures('de:8212:7')[0].route
    departures = kvvliveapi.get_departures('de:8212:7')
    departures = [dep for dep in departures if dep.route != 'E']
    return template('make_table', rows=departures)


@app.route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='static/')

#debug(True)
#run(reloader=True)
run(app, host='localhost', port=8080)