//
//  BeerDecoder.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-17.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import ObjectMapper

class BeersDecoder:DecoderProtocol{
    func decode(object: Any)->Any?{
        var decodedArray:Array<Beer>?
        if let objectSpecified = object as? [[String : Any]]
        {
            decodedArray = Mapper<BeerDTO>().mapArray(JSONArray: objectSpecified)
        }
        return decodedArray
    }
    
    
}
