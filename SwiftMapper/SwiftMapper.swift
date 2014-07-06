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
    
    func parse(json : Dictionary<String, Param>, to obj : T) -> T {
        for (attribute, value) in json {
            if let m = mappings[attribute] {
                m(obj, value)
            }
        }
        return obj
    }
}
