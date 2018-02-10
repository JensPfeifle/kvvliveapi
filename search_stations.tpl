<html lang="en">
<head>
    <title>Stationssuche</title>
    <link rel="stylesheet" type="text/css" href="static/mystyle.css">
</head>
<body style="background-color:black;color:white;font-family:helvetica,sans-serif">
<h4>Suche nach Stationsnamen</h4>
<form action="/kvv_search" method="get">
    <input name="search_for" type="text">
    <input value="Search" type="submit">
</form>
%if stations:
<h4>Ergebnisse</h4>
<table border="0" rules="rows" cellspacing="10px" width="100%">
    <tr>
        <td width="70%">
             <font size="+3">Station</font>
        </td>
        <td width="30%">
            <font size="+3">Monitor</font>
        </td>
    </tr>
%for station in stations:
    <tr>
        <td >
            {{station.name}}
        </td>
        <td>
            <a href="/kvv_table?station={{station.stop_id}}">{{station.stop_id}}</a>
        </td>
    </tr>
%end
</table>
%end
</body>
</html>