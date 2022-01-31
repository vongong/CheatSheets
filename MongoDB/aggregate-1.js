db = db.getSiblingDB("TCCloudUM");
db.getCollection("Authorization").aggregate([
	{
		"$match": {
			"$and": [
				{
					"authorizationNbr": { "$exists": true }
				},
				{
					"createdTs": { 
						"$gte":  new Date((new Date().getTime() - (30 * 24 * 60 * 60 * 1000))) // 30days prior
						// "$gte" : ISODate("2021-08-01T05:00:00.000+0000")
					}
				},
				{
					"businessUnitCd": 123
				},
				{
					"businessLine":  { "$regex": "^Place$", "$options": "i" }
				}
			]
		}
	}
	, {
		"$unwind": {
			"path": "$reviews",
			"preserveNullAndEmptyArrays": true
		}
	}
	, { 
		"$addFields": { 
			"lineItemLast": {
				"$arrayElemAt": [ "$lineItems", -1 ] 
			}
		}
	}
	, {
		"$project": {
			"authorizationNbr": 1,
			"authTypeDesc": 1,
			"authOwnerName": 1,
			"businessLine": 1,
			"businessUnitDesc": 1,
			"createdByName": 1,
			"createdTs": 1,
			"reviewName": "$reviews.name",
			"lineDescription": "$lineItemLast.description",
		}
	}
]);	
