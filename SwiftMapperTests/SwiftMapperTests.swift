//
//  SwiftMapperTests.swift
//  SwiftMapperTests
//
//  Created by Kamil Borzym on 05.07.2014.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import XCTest

class User
{
    var identifier : String?
    var username : String?
    var photo : String?
    var age : Int?
    var smoker : Bool?
    
    var description : String {
    return "User \(username) (id:\(identifier)) aged \(age) photo \"\(photo)\"" + (smoker ? " smoking" : "")
    }
}

class SwiftMapperTests: XCTestCase {

    var descriptor : SwiftMapperDescriptor<User>!

    override func setUp() {
        super.setUp()
        descriptor = SwiftMapperDescriptor<User>()
        
        descriptor.add("username", { $0.username = $1.asString })
        descriptor.add("identifier", { $0.identifier = $1.asString })
        descriptor.add("photo", { $0.photo = $1.asString })
        descriptor.add("age", { $0.age = $1.asInt })
        descriptor.add("smoker", { $0.smoker = $1.asBool })
    }
    
    func testExample() {
        let userJSON : Dictionary<String, Param> = [
            "username" : StringParam(string: "John Doe"),
            "identifier" : StringParam(string: "user8723"),
            "photo" : StringParam(string: "http://imgur.com/photo1.png"),
            "age" : IntParam(int: 27),
            "smoker" : BoolParam(bool: true)
        ]

        let parsedUser = descriptor.parse(userJSON, obj: User())
        
        XCAssertEquals("", parsedUser.description())
    }
}
