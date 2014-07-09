//
//  SwiftMapper.swift
//  SwiftMapper
//
//  Created by Kamil Borzym on 05.07.2014.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

class SwiftMapperDescriptor <T> {
    
    var mappings : Dictionary<String, (T, AnyObject) -> ()> = [:]
    
    subscript(attribute : String) -> ((T, AnyObject) -> ())? {
        get {
            return mappings[attribute]
        }
        set {
            mappings[attribute] = newValue
        }
    }
    
    func parse(json : String, to obj : T) -> T {
        let jsonDict : [String:AnyObject] = asDictionary(json)
        for (attribute, value) in jsonDict {
            if let m = mappings[attribute] {
                m(obj, value)
            }
        }
        return obj
    }
    
    func asDictionary(json : String) -> [String:AnyObject] {
        let data : NSData = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        var error : NSError?
        let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        var result : [String:AnyObject] = [:]
        for (key,value) in jsonObject {
            let stringKey = key as String
            switch value {
                case is String:
                    result[stringKey] = value as String
                case is Int:
                    result[stringKey] = value as Int
                case is Bool:
                    result[stringKey] = value as Bool
                case is [AnyObject]:
                    result[stringKey] = value as [AnyObject]
                case is [String:AnyObject]:
                    result[stringKey] = value as [String:AnyObject]
                default:
                    println("Value for key \(stringKey): \(value)")
            }

        }
        return result
    }
}
