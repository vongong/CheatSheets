db.foo.aggregate([ 
	{ "$group": {
		"_id":		"$cat", 
		"count": 	{"$sum":1},
		"qty_cnt":	{"$sum":"$qty"},
		"average":	{"$avg":"$price"},
		"low": 		{"$min":"$price"},
		"high":		{"$max":"$price"}
		} 
	}
]);
