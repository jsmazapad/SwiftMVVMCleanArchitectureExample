//
//  PaginatedTableViewVM.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-24.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import Bond

class PaginatedTableViewVM<T>:BaseTableViewVM<T>{
    
    var currentPage:Observable<Int> = Observable(ConfigConstants.firstPage)
    var advanceNextPage = false
    var firstPage:Observable<Bool> = Observable(true)
    var lastPage:Observable<Bool> = Observable(false)
    
    override init(tableview:UITableView, title:String){
        
        super.init(tableview: tableview, title:title)
        
        _ = currentPage.observeNext{
            value in
            self.firstPage.value = value == ConfigConstants.firstPage
            
        }
        _ = elements.observeNext{
            value in
            self.lastPage.value = value.count == 0
            
        }
        
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
       Returns the number of items to show per page
     - returns: Number of items to show per page
       */
    func getNumItemsPerPage()->Int{
        return ConfigConstants.numItemsPerPage
    }
    
}
