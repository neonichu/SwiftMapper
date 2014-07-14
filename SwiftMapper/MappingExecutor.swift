//
//  MappingExecutor.swift
//  SwiftMapper
//
//  Created by krzysztofsiejkowski on 14/07/14.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

class MappingExecutor<FieldType, ObjectType, CollectionType> {
    
    class func inoutExecution(inout a: FieldType, b: (inout FieldType) -> ()) -> () {
        b(&a)
    }
    
    class func optionalInoutExecution(inout a: FieldType?, b: (inout FieldType?) -> ()) -> () {
        b(&a)
    }
    
    class func nonOptional(left: (Mapper<ObjectType>, String), inout _ right: FieldType) {
        return self.inoutExecution(&right, { (inout b: FieldType) in
            if let value: AnyObject = left.0.valueFor(left.1) {
                for validation in left.0.validations[left.1]! {
                    if !validation.validate(value) {
                        return
                    }
                }
                switch FieldType.self {
                case is Bool.Type:
                    b = (value as Bool) as FieldType
                case is Int.Type:
                    b = (value as Int) as FieldType
                case is String.Type:
                    b = (value as String) as FieldType
                case is Array<CollectionType>.Type:
                    b = (value as Array<CollectionType>) as FieldType
                case is Dictionary<String, CollectionType>.Type:
                    b = (value as Dictionary<String, CollectionType>) as FieldType
                default:
                    return
                }
            }})
    }
    
    class func optional(left: (Mapper<ObjectType>, String), inout _ right: FieldType?) {
        return
            self.optionalInoutExecution(&right, { (inout b: FieldType?) in
                if let value: AnyObject = left.0.valueFor(left.1) {
                    for validation in left.0.validations[left.1]! {
                        if !validation.validate(value) {
                            return
                        }
                    }
                    switch FieldType.self {
                    case is String.Type:
                        b = (value as String) as? FieldType
                    case is Bool.Type:
                        b = (value as Bool) as? FieldType
                    case is Int.Type:
                        b = (value as Int) as? FieldType
                    case is Array<CollectionType>.Type:
                        b = (value as Array<CollectionType>) as? FieldType
                    case is Dictionary<String, CollectionType>.Type:
                        b = (value as Dictionary<String, CollectionType>) as? FieldType
                    default:
                        b = nil
                        return
                    }
                }
                })
    }
}
