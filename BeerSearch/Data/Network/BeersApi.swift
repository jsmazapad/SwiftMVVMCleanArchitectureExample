//
//  BeersApi.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import Bond
import Alamofire

class BeersApi:AlamofireWService, BeersApiProtocol{
    
    private let beersURL = "beers/"
    private enum beerParameters:String, CaseIterable{
        case food = "food"
        case page = "page"
        case resultsPerPage = "per_page"
        case ABVMinimumLevel = "abv_gt"
    }
    
    /**
     Retrieves a response with Beer items from the server
     - parameter food: a string containing the foods related to the beers to filter the results
     - parameter ABVMinimumLevel: The minimum ABV used to filter the beers returned
     - parameter pageNumber: The number of page to retrieve
     - parameter numItemsPerPage: number of items per page returned
     */
     func getBeers(food:String?, ABVMinimumLevel:Float, pageNumber:Int?, numItemsPerPage:Int, completion:@escaping (_ result: Response<Beer>) -> Void )
    {
        let page:Int = pageNumber ?? ConfigConstants.firstPage
        let url:String = beersURL
        
        var parameters:Dictionary<String, Any> = [:]
        
        if food != nil && food != ""
        {
            parameters = [beerParameters.food.rawValue : food!.replacingOccurrences(of:" ", with: "_")]
        }
        parameters[beerParameters.ABVMinimumLevel.rawValue] = ABVMinimumLevel
        parameters[beerParameters.page.rawValue] = page
        
        parameters[beerParameters.resultsPerPage.rawValue] = numItemsPerPage
        let _ = self.sendRequest(url: url, type: Beer(), decoder: BeersDecoder(), parameters: parameters, method:HTTPMethod.get,  completion: completion,  handler: handleArrayResponse)
        
    }
    
    
}
