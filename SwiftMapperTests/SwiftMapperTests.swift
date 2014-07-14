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
    var photoCount : Int = 0
    var age : Int?
    var drinker : Bool = false
    var smoker : Bool?
    var arr: [AnyObject] = []
    var arrOptional: [AnyObject]?
    var dict: [String:AnyObject] = [:]
    var dictOptional: [String:AnyObject]?
    
    var description : String {
    return "username: \(username) \nid:\(identifier) \naged: \(age) \nphotoCount: \(photoCount) \ndrinker: \(drinker) \nsmoker: \(smoker) \narr: \(arr) \narrOptional: \(arrOptional) \ndict: \(dict) \ndictOptional: \(dictOptional)"
    }
}

class SwiftMapperTests: XCTestCase {
    
    func testBasicParsing() {
        let mapper = Mapper<User>()
        mapper.map { (field, object) in
            field["username"] => object.username
            field["identifier"] => object.identifier
            field["photoCount"] => object.photoCount
            field["age"] => object.age
            field["drinker"] => object.drinker
            field["smoker"] => object.smoker
            field["arr"] => object.arr
            field["arrOpt"] => object.arrOptional
            field["dict"] => object.dict
            field["dictOpt"] => object.dictOptional
        }
        
        let testUsername = "John Doe"
        let testIdentifier = "user8723"
        let testPhoto = 13
        let testAge = 27
        let testDrinker = true
        let testSmoker = false
        let testArray = [ "bla", true, 42 ]
        let testDirectory = [
            "key1" : "value1",
            "key2" : false,
            "key3" : 142
        ]
        
        let userJSONString = "{\"username\":\"\(testUsername)\",\"identifier\":\"\(testIdentifier)\",\"photoCount\":\(testPhoto),\"age\":\(testAge),\"drinker\":\(testDrinker),\"smoker\":\(testSmoker), \"arr\":[ \"bla\", true, 42 ], \"dict\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }, \"arrOpt\":[ \"bla\", true, 42 ], \"dictOpt\":{ \"key1\" : \"value1\", \"key2\" : false, \"key3\" : 142 }}"
        let parsedUser = mapper.parse(userJSONString, to: User())
        
        println(parsedUser.description)
        
        XCTAssertEqualObjects(testUsername, parsedUser.username, "Username should be the same")
        XCTAssertEqualObjects(testIdentifier, parsedUser.identifier, "Identifier should be the same")
        XCTAssertEqualObjects(testPhoto, parsedUser.photoCount, "photo count should be the same")
        XCTAssertEqualObjects(testAge, parsedUser.age, "Age should be the same")
        XCTAssertEqualObjects(testDrinker, parsedUser.drinker, "Should be drinking")
        XCTAssertEqualObjects(testSmoker, parsedUser.smoker, "Should be smoking")
        XCTAssertEqualObjects(testArray, parsedUser.arr, "Array should be the same")
        XCTAssertEqualObjects(testDirectory, parsedUser.dict, "Dictionary should be the same")
        XCTAssertEqualObjects(testArray, parsedUser.arrOptional, "Array should be the same")
        XCTAssertEqualObjects(testDirectory, parsedUser.dictOptional, "Dictionary should be the same")
    }
    
    func testIntValidation() {
        
        let mapper = Mapper<User>()
        mapper.map { (field, object) in
            field.longer(11)["identifier"] => object.identifier
            field.min(30).max(40)["age"] => object.age
        }
        
        let testAgeFailing = 27
        let testAgePassing = 30
        let testAgeAlsoFailing = 42
        
        let userJSONStringFailing = "{\"age\":\(testAgeFailing), \"identifier\":\"1234567890\"}"
        let userJSONStringPassing = "{\"age\":\(testAgePassing)}"
        let userJSONStringAlsoFailing = "{\"age\":\(testAgeAlsoFailing)}"
        
        let parsedStringFailing = mapper.parse(userJSONStringFailing, to: User())
        XCTAssertNil(parsedStringFailing.identifier, "Identifier should not pass validation")
        
        let parsedUserFailing = mapper.parse(userJSONStringFailing, to: User())
        XCTAssertNil(parsedUserFailing.age, "Age should not pass validation")
        
        let parsedUserPassing = mapper.parse(userJSONStringPassing, to: User())
        XCTAssertEqualObjects(testAgePassing, parsedUserPassing.age, "Age should pass validation")

        let parsedUserAlsoFailing = mapper.parse(userJSONStringAlsoFailing, to: User())
        XCTAssertNil(parsedUserAlsoFailing.age, "Age should not pass validation")
        
        
    }

}
