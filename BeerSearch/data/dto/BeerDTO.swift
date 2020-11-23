//
//  BeerDTO.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-17.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import ObjectMapper

class BeerDTO:Beer, Mappable{
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        tagline <- map["tagline"]
        beerDescription <- map["description"]
        imageUrl <- map["image_url"]
        foodPairing <- map["food_pairing"]
        ABVLevel <- map["abv"]
    }
}
