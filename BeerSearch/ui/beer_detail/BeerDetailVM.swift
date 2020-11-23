//
//  BeerDetailVM.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-08.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit

class BeerDetailVM{
    
    func loadImage(imageUrl: String?, imageView: UIImageView){
        if let imageUrl = imageUrl{
        ImagesProvider.loadNetImage(urlImage: imageUrl, imageView: imageView)
        }
    }
    
    func getFoodsAsText(foods: Array<String>?)-> String{
        var foodsString = ""
        if let foods = foods{
            for food in foods{
                foodsString += "- \(food)\n"
            }
        }
        
        return foodsString
        
        
    }
    
}
