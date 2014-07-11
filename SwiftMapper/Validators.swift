//
//  Validators.swift
//  SwiftMapper
//
//  Created by krzysztofsiejkowski on 11/07/14.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

class Validator {
    func validate(value: AnyObject) -> Bool {
        return false
    }
}

class IntValidator : Validator {
    init() {}
    func validate(value: Int) -> Bool { return false }
}

class MinIntValidator : IntValidator {
    let min: Int
    init(min: Int) { self.min = min }
    override func validate(value: Int) -> Bool { return (value >= min) }
}

class MaxIntValidator : IntValidator {
    let max: Int
    init(max: Int) { self.max = max }
    override func validate(value: Int) -> Bool { return (value <= max) }
}