## Email - smart value - force datatime as cst
```html
	<tr><td><b>Start Time</b></td> <td>{{Planned start.convertToTimeZone("America/Chicago").longDateTime}}</td></tr>
	<tr><td><b>End Time:</b></td> <td>{{Planned end.convertToTimeZone("America/Chicago").longDateTime}}</td></tr>
```