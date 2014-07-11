//
//  Operators.swift
//  SwiftMapper
//
//  Created by krzysztofsiejkowski on 11/07/14.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

operator infix ! {}
func !<N> (inout a: N, b: (inout N) -> ()) -> () { b(&a) }

operator infix => {}
func =><T> (left: (Mapper<T>, String), inout right: String) -> () {
    return right ! { (inout b: String) in
        if let value: AnyObject = left.0.valueFor(left.1) {
            b = value as String
        }
    }
}

func =><T> (left: (Mapper<T>, String), inout right: String?) -> () {
    return right ! { (inout b: String?) in
            b = left.0.valueFor(left.1) as String?
    }
}

func =><T> (left: (Mapper<T>, String), inout right: Int) -> () {
    return right ! { (inout b: Int) in
        if let value: AnyObject = left.0.valueFor(left.1) {
            var passedValidation = true
            for validation in left.0.validations[left.1]! {
                passedValidation = validation.validate(value as Int) && passedValidation
            }
            if passedValidation {
                b = value as Int
            } else {
                b = -1
            }
        }
    }
}

func =><T> (left: (Mapper<T>, String), inout right: Int?) -> () {
    return right ! { (inout b: Int?) in
        if let value: AnyObject = left.0.valueFor(left.1) {
            var passedValidation = true
            for validation in left.0.validations[left.1]! {
                passedValidation = (validation as IntValidator).validate(value as Int) && passedValidation
            }
            if passedValidation {
                b = left.0.valueFor(left.1) as Int?
            } else {
                b = nil
            }
        } else {
            b = nil
        }
    }
}

func =><T> (left: (Mapper<T>, String), inout right: Bool) -> () {
    return right ! { (inout b: Bool) in
        if let value: AnyObject = left.0.valueFor(left.1) {
            b = value as Bool
        }
    }
}

func =><T> (left: (Mapper<T>, String), inout right: Bool?) -> () {
    return right ! { (inout b: Bool?) in
            b = left.0.valueFor(left.1) as Bool?
    }
}

func =><T> (left: (Mapper<T>, String), inout right: Array<AnyObject>) -> () {
    return right ! { (inout b: Array) in
        if let value: AnyObject = left.0.valueFor(left.1) {
            b = value as Array
        }
    }
}

func =><T> (left: (Mapper<T>, String), inout right: Array<AnyObject>?) -> () {
    return right ! { (inout b: Array<AnyObject>?) in
        b = left.0.valueFor(left.1) as Array?
    }
}

func =><T, N> (left: (Mapper<T>, String), inout right: Dictionary<String, N>) -> () {
    return right ! { (inout b: Dictionary) in
        if let value: AnyObject = left.0.valueFor(left.1) {
            b = value as Dictionary
        }
    }
}

func =><T, N> (left: (Mapper<T>, String), inout right: Dictionary<String, N>?) -> () {
    return right ! { (inout b: Dictionary<String, N>?) in
        b = left.0.valueFor(left.1) as Dictionary?
    }
}
