//
//  SearchBeersUseCase.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-17.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation

class SearchBeersUseCase: SearchBeersUseCaseProtocol{
    
    private let repository: BeerRepositoryProtocol
        
        init(repository: BeerRepositoryProtocol) {
            self.repository = repository
        }
        
        func execute(requestValue: BeerUseCaseRequestValue, completion: @escaping (Response<Beer>) -> Void) {
            repository.getBeers(foodName: requestValue.foodName, ABVMinimumLevel:requestValue.ABVMinimumLevel, pageNumber: requestValue.pageNumber, numItemsPerPage: requestValue.numItemsPerPage, completion: completion)
        }
}

struct BeerUseCaseRequestValue{
    let foodName:String?
    let ABVMinimumLevel:Float
    let pageNumber:Int?
    let numItemsPerPage:Int
}
