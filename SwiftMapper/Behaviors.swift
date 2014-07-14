//
//  Behaviors.swift
//  SwiftMapper
//
//  Created by krzysztofsiejkowski on 13/07/14.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

extension Mapper {
    func def(value: Int) -> MapperBehavior<Int> {
        return MapperBehavior<Int>(value)
    }
}

class MapperBehavior<T> {
    let defaultValue : T
    init (_ defaultValue: T) {
        self.defaultValue = defaultValue
    }
}
