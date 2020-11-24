//
//  BeersDecoderTest.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-24.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import XCTest

class BeersDecoderTest: XCTestCase {
    
    
    
    //Tests
    func testBeersDecoderWhenSuccessDecoding() {
        
        var json:[[String: Any]]?
        let data = BeersJSONStringFakeResponses.validData.data(using: .utf8)
        
        XCTAssertNotNil(data, "Array decoded is nil")
        if let data = data {
            do {
                json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
            let beers = BeersDecoder().decode(object: json ?? "")
            
            XCTAssertNotNil(beers, "Array decoded is not nil")
            
            if let beers = beers
            {
                XCTAssertTrue( beers as? Array<Beer> != nil, "Array decoded is from the type expected")
                
                if let beers = beers as? Array<Beer>
                {
                    XCTAssertTrue(beers.count == 2, "Array decoded count is ok")
                    XCTAssertTrue(beers[0].name == "Berliner Weisse With Yuzu - B-Sides", "Sample decoded element name is decoded ok")
                }
            }
            
            
        }
    }
    
    func testBeersDecoderWhenTryingToDecodeAnotherType() {
        
        let json:String = " "
        
        let beers = BeersDecoder().decode(object: json)
        
        XCTAssertNil(beers, "Array decoded is nil")
        
    }
    
    func testBeersDecoderWhenTryingToDecodeAnotherJSONType() {
        
        var json:[[String: Any]]?
        let testString:String = "[{\"example\":1}] "
        let data = testString.data(using: .utf8)
        
        XCTAssertNotNil(data, "Array decoded is nil")
        
        if let data = data {
            do {
                json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
            
            let beers = BeersDecoder().decode(object: json ?? "")
            
            XCTAssertNotNil(beers, "Array decoded is not nil")

            if let beers = beers
            {
                XCTAssertTrue( beers as? Array<Beer> != nil, "Array decoded is from the type expected")
                
                if let beers = beers as? Array<Beer>
                {
                    XCTAssertTrue(beers.count == 1, "Array decoded count is ok")
                    XCTAssertTrue(beers[0].name == nil, "Sample decoded element name is nil")
                }
            }
        }
        
    }
    
    
    
    
}
