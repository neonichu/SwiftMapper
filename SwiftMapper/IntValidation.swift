//
//  IntValidation.swift
//  SwiftMapper
//
//  Created by krzysztofsiejkowski on 13/07/14.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

extension Mapper {
    
    func min(min: Int) -> Mapper {
        return validator(MinIntValidator(min: min))
    }
    
    func max(max: Int) -> Mapper {
        return validator(MaxIntValidator(max: max))
    }
    
}

class MinIntValidator : MapperValidator {
    let min: Int
    init(min: Int) { self.min = min }
    func validate(value: AnyObject) -> Bool { return ((value as Int) >= min) }
}

class MaxIntValidator : MapperValidator {
    let max: Int
    init(max: Int) { self.max = max }
    func validate(value: AnyObject) -> Bool { return ((value as Int) <= max) }
}
