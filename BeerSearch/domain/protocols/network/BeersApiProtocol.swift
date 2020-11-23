//
//  BeersApiProtocol.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-18.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

protocol BeersApiProtocol{
    
     func getBeers(food:String?, ABVMinimumLevel:Float, pageNumber:Int?, numItemsPerPage:Int, completion:@escaping (_ result: Response<Beer>) -> Void )
}


