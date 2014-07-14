//
//  Operators.swift
//  SwiftMapper
//
//  Created by krzysztofsiejkowski on 11/07/14.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import Foundation

operator infix => {}

func =><T> (left: (Mapper<T>, String), inout right: Bool) -> () {
    return MappingExecutor<Bool, T, T>.nonOptional(left, &right)
}


func =><T> (left: (Mapper<T>, String), inout right: Bool?) -> () {
    return MappingExecutor<Bool, T, T>.optional(left, &right)
}

func =><T> (left: (Mapper<T>, String), inout right: String) -> () {
    println("zero: \(right)")
    return MappingExecutor<String, T, T>.nonOptional(left, &right)
}

func =><T> (left: (Mapper<T>, String), inout right: String?) -> () {
    return MappingExecutor<String, T, T>.optional(left, &right)
}

func =><T> (left: (Mapper<T>, String), inout right: Int) -> () {
    return MappingExecutor<Int, T, T>.nonOptional(left, &right)
}

func =><T> (left: (Mapper<T>, String), inout right: Int?) -> () {
        return MappingExecutor<Int, T, T>.optional(left, &right)
}

func =><T, N> (left: (Mapper<T>, String), inout right: Array<N>) -> () {
    return MappingExecutor<Array<N>, T, N>.nonOptional(left, &right)
}

func =><T, N> (left: (Mapper<T>, String), inout right: Array<N>?) -> () {
    return MappingExecutor<Array<N>, T, N>.optional(left, &right)
}

func =><T, N> (left: (Mapper<T>, String), inout right: Dictionary<String, N>) -> () {
    return MappingExecutor<Dictionary<String, N>, T, N>.nonOptional(left, &right)
}

func =><T, N> (left: (Mapper<T>, String), inout right: Dictionary<String, N>?) -> () {
    return MappingExecutor<Dictionary<String, N>, T, N>.optional(left, &right)
}

