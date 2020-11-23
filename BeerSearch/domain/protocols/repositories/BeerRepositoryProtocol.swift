//
//  BeerRepositoryProtocol.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-17.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation

protocol BeerRepositoryProtocol{
    func getBeers(foodName:String?, ABVMinimumLevel:Float, pageNumber:Int?, numItemsPerPage:Int, completion: @escaping (Response<Beer>) -> Void)
    
    func getApi()->BeersApiProtocol
}
