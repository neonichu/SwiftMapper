//
//  SwiftMapper.swift
//  SwiftMapper
//
//  Created by Kamil Borzym on 05.07.2014.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

class User
{
    var identifier : String?
    var username : String?
    var photo : String?
    var age : Int?
    var smoker : Bool?
    
    var description : String {
        return "User \(username) (id:\(identifier)) aged \(age) photo \"\(photo)\"" + (smoker ? " smoking" : "")
    }
}

let userJSON = [
    "username" : "John Doe",
    "identifier" : "user8723",
    "photo" : "http://imgur.com/photo1.png",
    "age" : 27,
    "smoker" : true
]

//class SwiftMapper {
//    
//    func parse<T>(json : Dictionary, toObject: T) {
//        
//    }
//    
//    
//    
//}

protocol Param {
    var asString : String { get }
    var asInt : Int { get }
    var asBool : Bool { get }
}

class BoolParam : Param {
    init(arg : Bool) {
        asBool = arg
    }
    var asBool : Bool
    var asString : String {
        return String(asBool)
    }
    var asInt : Int {
        return asBool ? 1 : 0
    }
}

class IntParam : Param {
    init(arg : Int) {
        asInt = arg
    }
    var asInt : Int
    var asString : String {
        return String(asInt)
    }
    var asBool : Bool {
        return asInt != 0
    }
}

class StringParam : Param {
    init(arg : String) {
        asString = arg
    }
    var asString : String
    var asInt : Int {
        return asString.toInt()!
    }
    var asBool : Bool {
        return asString.lowercaseString == "true"
    }
}

class SwiftMapperDescriptor <T> {
    
    var mappings : Dictionary<String, (T, Param) -> ()> = [:]
    
    func add(attribute : String, mapping : (T, Param) -> ()) {
        mappings[attribute] = mapping
    }
    
    func parse(json : Dictionary<String, Any>) {
        for (attribute, value) in json {
            
        }
    }
}

class Test {
    func test() {

        let descriptor = SwiftMapperDescriptor<User>()
        
        descriptor.add("username", { $0.username = $1.asString })
        descriptor.add("identifier", { $0.identifier = $1.asString })
        descriptor.add("photo", { $0.photo = $1.asString })
        descriptor.add("age", { $0.age = $1.asInt })
        descriptor.add("smoker", { $0.smoker = $1.asBool })

        
    }
}