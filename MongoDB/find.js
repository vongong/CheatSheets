db.getCollection("test").find(
    { "key": "value" } // filter
    ,{ "key": "value" } //Projection
);

db.user.find().pretty();