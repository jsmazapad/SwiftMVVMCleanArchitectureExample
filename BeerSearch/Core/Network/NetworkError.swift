//
//  NetworkError.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-18.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation

class NetworkError:NSError
{
    required convenience init(message:String, code:Int) {
        self.init(domain:"NetworkError", code:code, userInfo:[ NSLocalizedDescriptionKey: message])
    }
}
