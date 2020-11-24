//
//  BeersVM.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit
import Bond

class BeersVM:PaginatedTableViewVM<Beer>
{
    private var useCase: SearchBeersUseCaseProtocol!
    var searchText:String?
    var ABVValue:Float = 0.0
    
    
    required init(tableview:UITableView){
        
        super.init(tableview: tableview, title:NSLocalizedString("title.main", comment: ""))
        self.useCase = self.getSearchBeersUseCase()
        
    }
    
    
    override func loadData(){
        isLoading.value = true
        let numItemsPerPage = getNumItemsPerPage()
        useCase.execute(requestValue: .init(foodName: searchText, ABVMinimumLevel: ABVValue, pageNumber: currentPage.value, numItemsPerPage: numItemsPerPage), completion: {response in
            self.onRepositoryResponse(response: response.response, error:response.error)
        })
        
    }
    
    override func processResponse(response: Array<Any>?) -> Array<Beer> {
        return response as! Array<Beer>
        
    }
    
    
    /**
    Performs a search retrieving data from the server
     - parameter searchString: String used to search
     - parameter ABVValue: Minimum ABV of the elements returned
    */
    func performSearch(searchText:String?, ABVValue:Float){
        self.searchText = searchText
        self.ABVValue = ABVValue
        resetPageCounter()
        loadData()
    }
    
}

extension BeersVM{
    
    func getSearchBeersUseCase()->SearchBeersUseCaseProtocol{
           return SearchBeersUseCase(repository: self.getRepository())
       }
       
       func getRepository()->BeerRepositoryProtocol{
           return BeerRepository()
       }
}

