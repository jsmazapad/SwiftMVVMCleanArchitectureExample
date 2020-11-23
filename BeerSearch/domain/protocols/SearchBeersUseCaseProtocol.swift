//
//  SearchBeersUseCaseProtocol.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-18.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation

protocol SearchBeersUseCaseProtocol{
    
    func execute(requestValue: BeerUseCaseRequestValue, completion: @escaping (Response<Beer>) -> Void)
}
