
//inc - increment
db.foo.update({_id:1}, {$inc:{val:1}})
//set - add new field
db.foo.update({_id:1}, {$set:{z:1000}})
//unset - remove field
db.foo.update({_id:1}, {$unset:{z:0}})
//rename - rename field
db.foo.update({_id:1}, {$rename:{'naem':'name'}})
//push - add to array
db.foo.update({_id:1}, {$push: {things:'one'}} )
db.foo.update({_id:1}, {$push: {things:'two'}} )
db.foo.update({_id:1}, {$push: {things:'three'}} )
db.foo.update({_id:1}, {$push: {things:'three'}} )
//addtoset - like push, but no dups
db.foo.update({_id:1}, {$addToSet: {things:'three'}} )
db.foo.update({_id:1}, {$addToSet: {things:'three'}} )
db.foo.update({_id:1}, {$addToSet: {things:'four'}} )
db.foo.update({_id:1}, {$addToSet: {things:'four'}} )
//pull - pull all instances out of array
db.foo.update({_id:1}, {$pull: {things:'three'}} )
//pop - pop last n items in array
db.foo.update({_id:1}, {$pop: {things:1}})