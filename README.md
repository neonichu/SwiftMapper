SwiftMapper
===============

JSON mapper written in Swift during [Swift Crunch 2014](http://swiftcrunch.com/) in Cracow on July 5th & 6th 2014 just for fun!

Authors
-------
[![Maciej Kozieł](https://s3.amazonaws.com/uploads.hipchat.com/photos/998094/PilxzEaCYJ5IEZj_125.jpg)](https://www.linkedin.com/in/mkoziel)
[![Kamil Borzym](https://s3.amazonaws.com/uploads.hipchat.com/photos/998120/KCOvRimHcvnFK1n_125.jpg)](https://github.com/kam800)
[![Łukasz Kuczborski](https://s3.amazonaws.com/uploads.hipchat.com/photos/998161/uyRN9GDPl7eUEss_125.jpg)](https://twitter.com/lkuczborski)
[![Antonio Bello](https://s3.amazonaws.com/uploads.hipchat.com/photos/998123/NNJdv0LKldkEU60_125.jpg)](https://twitter.com/ant_bello)

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
}
```

Your JSON string:
```
{
    "username" : "John Doe",
    "identifier" : "user8723",
    "photo" : "http://imgur.com/photo1.png",
    "age" : 27,
    "smoker" : true
}
```

You need to create entity mepping descriptor in format
```
descriptor["jsonAttribute"] = { $0.property = $1.asFormat }
```

Descriptor mapping for User entity
```swift
let descriptor = SwiftMapperDescriptor<User>()
        
descriptor["username"] = { $0.username = $1.asString }
descriptor["identifier"] = { $0.identifier = $1.asString }
descriptor["photo"] = { $0.photo = $1.asString }
descriptor["age"] = { $0.age = $1.asInt }
descriptor["smoker"] = { $0.smoker = $1.asBool }
```

And now we invoke magic :)
```
let parsedUser = descriptor.parse(jsonString, User())
```

What do we support?
-------------------
* parsing objects
* string, integer and boolean json values

What is missing?
----------------
* arrays, dictionaries
* nested types
* error checking
* validation
* refactoring and finishing touches

We need help!
-------------
Does anyone know how to avoid this ugly closure syntax and specify only properties?

