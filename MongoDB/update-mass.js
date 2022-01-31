
//Uppercase Field
db.foo.find().forEach(
    function(e) {
        db.foo.update({_id: e._id},
            {$set: {userId: e.userId.toUpperCase()} })
    }
);

//faster 3.6+
var bulk = db.foo.initializeUnorderedBulkOp();
var count = 0
db.foo.find().forEach(function(e) {
    bulk.find({_id:e._id}).updateOne({$set:{userId: e.userId.toUpperCase()}})
    count++
    if (count % 500 === 0) {
        bulk.execute();
        bulk = db.foo.initializeUnorderedBulkOp();
        count = 0;
    }
})
if (count > 0)  bulk.execute();

//Uppercase - Agg Function (4.2+)
db.foo.update(
	{},
	[{ $set: { userId: { $toUpper: "$userId" } } }],
	{ multi: true }
);