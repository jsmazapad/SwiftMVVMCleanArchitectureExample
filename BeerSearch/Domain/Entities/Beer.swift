//
//  Beer.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation

class Beer : NSObject {

    
    var id : Int?
    var name : String?
    var tagline : String?
    var beerDescription : String?
    var imageUrl : String?
    var foodPairing : [String]?
    var ABVLevel: Float?
    
    convenience init(id: Int?, name: String?, tagline: String?, beerDescription: String?, imageUrl: String?, foodPairing: [String]?, ABVLevel: Float?) {
        self.init()
        self.id = id
        self.name = name
        self.tagline = tagline
        self.beerDescription = description
        self.imageUrl = imageUrl
        self.foodPairing = foodPairing
        self.ABVLevel = ABVLevel
    }

}
