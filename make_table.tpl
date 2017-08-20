<head>
    <title>Abfahrtzeiten {{station}}</title>
    <link rel="stylesheet" type="text/css" href="static/mystyle.css">
</head>
<meta http-equiv="refresh" content="30" >
<body style="background-color:black;color:white;font-family:helvetica,sans-serif" >
<h1>Abfahrtszeiten {{station}}</h1>
<table border="0" rules="rows" cellspacing="10px" width="100%">
%for row in rows:
  <tr>
      <td width="120px">
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
%end
</table>
</body>