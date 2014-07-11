//
//  SwiftMapperTests.swift
//  SwiftMapperTests
//
//  Created by Kamil Borzym on 05.07.2014.
//  Copyright (c) 2014 Swiftcrunch. All rights reserved.
//

import XCTest

class User {
    var username : String = ""
    var identifier : String?
    var photo : String = ""
    var age : Int = 0
    var smoker : Bool = false
    var arr: [AnyObject]?
    var dict: [String:AnyObject]?
    
    var description : String {
    return "User \(username) (id:\(identifier)) aged \(age) photo \"\(photo)\"" + (smoker ? " smoking" : "") + "arr: \(arr), dict: \(dict)"
    }
}

class SwiftMapperTests: XCTestCase {
    
    var mapper : Mapper<User>!
    
    override func setUp() {
        super.setUp()
        mapper = Mapper<User>()
        
        mapper.map({ (field, object) in
            field["username"] => object.username
            field["identifier"] => object.identifier
            field["photo"] => object.photo
            field["age"] => object.age
            field["smoker"] => object.smoker
            field["arr"] => object.arr
            field["dict"] => object.dict
        })
        
    }
    
    func test() {
        let testUsername = "John Doe"
        let testIdentifier = "user8723"
        let testPhoto = "http://imgur.com/photo1.png"
        let testAge = 27
        let testSmoker = true
        let testArray = [ "bla", true, 42 ]
        let testDirectory = [
            "key1" : "value1",
            "key2" : false,
            "key3" : 142
        ]
        
        let userJSONString = "{\"username\":\"\(testUsername)\",\"identifier\":\"\(testIdentifier)\",\"photo\":\"\(testPhoto)\",\"age\":\(testAge),\"smoker\":\(testSmoker), \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }}"
        let parsedUser = mapper.parse(userJSONString, to: User())
        
        println(parsedUser.description)
        
        XCTAssertEqualObjects(testUsername, parsedUser.username, "Username should be the same")
        XCTAssertEqualObjects(testIdentifier, parsedUser.identifier, "Identifier should be the same")
        XCTAssertEqualObjects(testPhoto, parsedUser.photo, "photo URL should be the same")
        XCTAssertEqualObjects(testAge, parsedUser.age, "Age should be the same")
        XCTAssertEqualObjects(testSmoker, parsedUser.smoker, "Should be smoking (but it is unhealthy)")
        XCTAssertEqualObjects(testArray, parsedUser.arr, "Array should be the same")
        XCTAssertEqualObjects(testDirectory, parsedUser.dict, "Dictionary should be the same")
    }
}
