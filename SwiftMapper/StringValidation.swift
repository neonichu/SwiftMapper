//
//  StringValidation.swift
//  SwiftMapper
//
//  Created by krzysztofsiejkowski on 14/07/14.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

extension Mapper {
    func longer(length: Int) -> Mapper {
        return validator(LengthStringValidator(length: length))
    }
}

class LengthStringValidator : MapperValidator {
    let length: Int
    init(length: Int) { self.length = length }
    func validate(value: AnyObject) -> Bool { return (countElements(value as String) >= length) }
}