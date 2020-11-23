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

class BeersVM:ParentTableViewVM<Beer>
{
    private var useCase: SearchBeersUseCaseProtocol!
    var searchText:String?
    var ABVValue:Float = 0.0
    var currentPage:Observable<Int> = Observable(ConfigConstants.firstPage)
    var advanceNextPage = false
    var firstPage:Observable<Bool> = Observable(true)
    var lastPage:Observable<Bool> = Observable(false)
    
    
    required init(tableview:UITableView){
        
        super.init(tableview: tableview, title:"PUNK API")
        self.useCase = self.getSearchBeersUseCase()
        _ = currentPage.observeNext{
            value in
            self.firstPage.value = value == ConfigConstants.firstPage
            
        }
        _ = elements.observeNext{
            value in
            self.lastPage.value = value.count == 0
            
        }
        
    }
    
    
    override func loadData(){
        isLoading.value = true
        let numItemsPerPage = ConfigConstants.numItemsPerPage
        
        useCase.execute(requestValue: .init(foodName: searchText, ABVMinimumLevel: ABVValue, pageNumber: currentPage.value, numItemsPerPage: numItemsPerPage), completion: {response in
            self.onRepositoryResponse(response: response.response, error:response.error)
        })
        
    }
    
    override func processResponse(response: Array<Any>?) -> Array<Beer> {
        return response as! Array<Beer>
        
    }
    
    /**
     Loads next page retrieving data from server
     */
    func loadNextPage(){
        currentPage.value+=1
        loadData()
        
    }
    
    /**
    Loads previous page retrieving data from server
    */
    func loadPreviousPage(){
        if currentPage.value > ConfigConstants.firstPage
        {
            currentPage.value-=1
        }
        loadData()
        
    }
    /**
    Resets page counter to initial value given in config
    */
    func resetPageCounter(){
        currentPage.value = ConfigConstants.firstPage
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

