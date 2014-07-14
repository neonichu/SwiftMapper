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

class IntValidator : MapperValidator {
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
