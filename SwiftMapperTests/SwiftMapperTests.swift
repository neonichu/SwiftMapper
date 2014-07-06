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
        
        descriptor["username"] = { $0.username = $1.asString }
        descriptor["identifier"] = { $0.identifier = $1.asString }
        descriptor["photo"] = { $0.photo = $1.asString }
        descriptor["age"] = { $0.age = $1.asInt }
        descriptor["smoker"] = { $0.smoker = $1.asBool }
    }
    
    func equalityTest() {
        let userJSONString = "{\"username\":\"John Doe\",\"identifier\":\"user8723\",\"photo\":\"http://imgur.com/photo1.png\",\"age\":27,\"smoker\":true}"

        let parsedUser = descriptor.parse(userJSONString, to: User())
        
        XCTAssertEqual("John Doe", parsedUser.username! as String, "Username should be the same")
        XCTAssertEqual("user8723", parsedUser.identifier!, "Identifier should be the same")
        XCTAssertEqual("http://imgur.com/photo1.png", parsedUser.photo!, "photo URL should be the same")
        XCTAssertEqual(27, parsedUser.age!, "Age should be the same")
        XCTAssertTrue(parsedUser.smoker!, "Should be smoking (but it is unhealthy)")
        XCTAssertEqual("User John Doe (id:user8723) aged 27 photo \"http://imgur.com/photo1.png\" smoking", parsedUser.description, "Description should be correct")
    }
}
