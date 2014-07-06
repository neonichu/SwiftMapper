//
//  SwiftMapper.swift
//  SwiftMapper
//
//  Created by Kamil Borzym on 05.07.2014.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

protocol Param {
    var asString : String { get }
    var asInt : Int { get }
    var asBool : Bool { get }
}

class BoolParam : Param {
    init(bool : Bool) {
        asBool = bool
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
    init(int : Int) {
        asInt = int
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
    init(string : String) {
        asString = string
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
    
    func parse(json : String, to obj : T) -> T {
        let jsonDict : Dictionary<String, Param> = asDictionary(json)
        for (attribute, value) in jsonDict {
            if let m = mappings[attribute] {
                m(obj, value)
            }
        }
        return obj
    }
    
    func asDictionary(json : String) -> Dictionary<String, Param> {
        let data : NSData = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        var error : NSError?
        let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        var result : Dictionary<String, Param> = [:]
        for (key,value) in jsonObject {
            let stringKey = key as String
            if let stringValue = value as? String {
                result[stringKey] = StringParam(string:stringValue)
            } else if let intValue = value as? Int {
                result[stringKey] = IntParam(int:intValue)
            } else if let boolValue = value as? Bool {
                result[stringKey] = BoolParam(bool:boolValue)
            }

        }
        return result
    }
}
