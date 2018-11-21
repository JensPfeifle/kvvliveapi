<html lang="en">
<head>
    <title>Abfahrtzeiten</title>
    <link rel="stylesheet" type="text/css" href="static/mystyle.css">
</head>
<meta http-equiv="refresh" content="30" >
<body style="background-color:black;color:white;font-family:helvetica,sans-serif" >
<div align="right"><h1>{{time}}</h1></div>
<h1>Abfahrtszeiten {{station1}}</h1>
<table style="float: left" border="0" rules="rows" cellspacing="10px" width="50%">
 <tr> 
      <td width="240px">
          <font color="white" size="+2">Richtung Marktplatz </font>
      </td>
 </tr>
%n = 0
%for row in rows11:
  <tr>
      <td width="500px">
          <font color="white" size="+2">{{row.pretty_time()}}</font>
      </td>
      <td class="route" width="40px" align="center">
          <div style="background-color:{{row.route_color}};color:white;padding:2px;margin:2px;border-radius:5px">
              <font size="+2">{{(row.route)}}</font>
          </div>
      </td>
      <td>
           <font color="white" size="+2">{{row.destination}}</font>
      </td>
  </tr>
  %n+=1
%end
%for i in range(n,10):
  % include('empty_row.tpl')
%end
</table>
<table style="float: left" border="0" rules="rows" cellspacing="10px" width="50%">
 <tr> 
      <td width="240px">
          <font color="white" size="+2">Richtung Durlach </font>
      </td>
 </tr>
%n = 0
%for row in rows12:
  <tr>
      <td width="500px">
          <font color="white" size="+2">{{row.pretty_time()}}</font>
      </td>
      <td class="route" width="40px" align="center">
          <div style="background-color:{{row.route_color}};color:white;padding:2px;margin:2px;border-radius:5px">
              <font size="+2">{{(row.route)}}</font>
          </div>
      </td>
      <td>
           <font color="white" size="+2">{{row.destination}}</font>
      </td>
  </tr>
  %n+=1
%end
%for i in range(n,10):
  % include('empty_row.tpl')
%end
</table>
<h1>&nbsp;</h1>
<h1>Abfahrtszeiten {{station2}}</h1>
<table style="float: left" border="0" rules="rows" cellspacing="10px" width="50%">
 <tr> 
      <td width="240px">
          <font color="white" size="+2">Richtung Kronenplatz </font>
      </td>
 </tr>
 %n = 0
 %for row in rows21:
  <tr>
      <td width="500px">
          <font color="white" size="+2">{{row.pretty_time()}}</font>
      </td>
      <td class="route" width="40px" align="center">
          <div style="background-color:{{row.route_color}};color:white;padding:2px;margin:2px;border-radius:5px">
              <font size="+2">{{(row.route)}}</font>
          </div>
      </td>
      <td>
           <font color="white" size="+2">{{row.destination}}</font>
      </td>
  </tr>
  %n+=1
%end
%for i in range(n,10):
  % include('empty_row.tpl')
%end
</table>
<table style="float: left" border="0" rules="rows" cellspacing="10px" width="50%">
 <tr> 
      <td width="240px">
          <font color="white" size="+2">Richtung Tivoli </font>
      </td>
 </tr>
%n = 0
%for row in rows22:
  <tr>
      <td width="500px">
          <font color="white" size="+2">{{row.pretty_time()}}</font>
      </td>
      <td class="route" width="40px" align="center">
          <div style="background-color:{{row.route_color}};color:white;padding:2px;margin:2px;border-radius:5px">
              <font size="+2">{{(row.route)}}</font>
          </div>
      </td>
      <td>
           <font color="white" size="+2">{{row.destination}}</font>
      </td>
  </tr>
  %n+=1
%end
%for i in range(n,10):
  % include('empty_row.tpl')
%end
</table>
</body>
</html>
