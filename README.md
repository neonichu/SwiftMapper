SwiftMapper
===============

First vesion of JSON mapper was written in Swift during [Swift Crunch 2014](http://swiftcrunch.com/) in Cracow on July 5th & 6th 2014 - just for fun!

Then we decided that there is nothing wrong with having fun after the hackathon as well.

Authors
-------
[![Maciej Kozieł](https://s3.amazonaws.com/uploads.hipchat.com/photos/998094/PilxzEaCYJ5IEZj_125.jpg)](https://www.linkedin.com/in/mkoziel)
[![Kamil Borzym](https://s3.amazonaws.com/uploads.hipchat.com/photos/998120/KCOvRimHcvnFK1n_125.jpg)](https://github.com/kam800)
[![Antonio Bello](https://s3.amazonaws.com/uploads.hipchat.com/photos/998161/uyRN9GDPl7eUEss_125.jpg)](https://twitter.com/ant_bello)
[![Łukasz Kuczborski](https://s3.amazonaws.com/uploads.hipchat.com/photos/998123/NNJdv0LKldkEU60_125.jpg)](https://twitter.com/lkuczborski)
[![Krzysztof Siejkowski](https://s3.amazonaws.com/uploads.hipchat.com/photos/998121/7nrliimkJor63RB_125.jpg)](https://twitter.com/_siejkowski)


Sample Usage
------------

Your model entity:
```swift
class User
{
    var identifier : String?
    var username : String?
    var photo : String?
    var age : Int?
    var smoker : Bool?
    var arr : []?
    var dict : [:]?
}
```

Your JSON string:
```
{
    "username" : "John Doe",
    "identifier" : "user8723",
    "photo" : "http://imgur.com/photo1.png",
    "age" : 27,
    "smoker" : true,
    "arr" : [ "bla", false, 42],
    "dict" : { "key1" : "value1", "key2" : 0, "key3" : 142 }
}
```

You need to create entity mapper in format
```
mapper.map { (field, object) in
    field["jsonAttribute"] => object.property
}
```

Descriptor mapping for User entity
```swift
let mapper = Mapper<User>()
        
mapper.map { (field, object) in
    field["username"] => object.username
    field["identifier"] => object.identifier
    field["photo"] => object.photo
    field["age"] => object.age
    field["smoker"] => object.smoker
    field["arr"] => object.arr
    field["dict"] => object.dict
}
```

And now we invoke magic :)
```
let parsedUser = mapper.parse(jsonString, to: User())
```

Validation
------------

We can validate the fields while mapping. 

If the condition is not satisfied and we're mapping at optional property, the value will be set to nil.

If the condition is not satisfied and we're mapping at non-optional property, the value will not be changed at all.

```
mapper.map { (field, user) in
    field.min(18).max(200)["age"] => user.age
}
```

For now, very limited validation is supported - only min and max for Int properties.


What do we support?
-------------------
* parsing objects
* string, integer, boolean, arrays and dictionaries json values
* vary limited validation

What is missing?
----------------
* full validation
* nested types
* error checking
* refactoring and finishing touches

We need help!
-------------
Does anyone know how to inject the values into class with immutable properties? Parsing in constructor doesn't help.

