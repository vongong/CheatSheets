db.user.find().pretty();

db.user.find({"isDonor": {$exists:true}})
db.user.find({"isDonor": null});

db.user.find({"lastname" : {"$exists" : true, "$ne" : ""}})

db.user.find({"music": { $in :['Blues','Country']}});
db.user.find({"music": { $all :['Blues','Country']}});

db.user.find(
    {"Status": {"$regex": "^VOID*", "$options":"i"}}
);

db.user.find(
{   "createdTs" : {"$gte" : new Date((new Date().getTime() - (60 * 24 * 60 * 60 * 1000)))}
    ,"createdTs" : {"$lte" : new Date((new Date().getTime() ))}
}
);