//
//  BeerRepository.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import Bond

class BeerRepository:BeerRepositoryProtocol{
    
    /**
     Retrieves a response with Beer items 
     - parameter food: a string containing the foods related to the beers to filter the results
     - parameter ABVMinimumLevel: The minimum ABV used to filter the beers returned
     - parameter pageNumber: The number of page to retrieve
     - parameter numItemsPerPage: number of items per page returned
     */
    func getBeers(foodName:String?, ABVMinimumLevel:Float, pageNumber:Int?, numItemsPerPage:Int, completion: @escaping (Response<Beer>) -> Void){
        
        getApi().getBeers(food: foodName, ABVMinimumLevel:ABVMinimumLevel, pageNumber:pageNumber, numItemsPerPage: numItemsPerPage, completion: completion)
    }
    
    func getApi()->BeersApiProtocol{
        return BeersApi()
    }
}
