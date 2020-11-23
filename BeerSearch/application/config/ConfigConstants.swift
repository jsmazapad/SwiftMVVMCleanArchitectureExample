//
//  ConfigConstants.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit

class ConfigConstants{

    //PAGE PARAMETERS
    static let numItemsPerPage = 15
    static let firstPage = 1
    //ALCOHOL FILTER
    static let ABVMaximumLevel:Float = 60.0

    //BASE URL
    static func getBaseUrl()-> String {
        return infoForKey("base_url")!
    }

    private static func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }

}

