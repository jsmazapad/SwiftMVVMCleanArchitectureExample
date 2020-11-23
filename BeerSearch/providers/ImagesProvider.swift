//
//  ImagesProvider.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit
class ImagesProvider{
    
    /**
     Retrieves an image from an url an lazy loads it on a imageView
     - parameter urlImage: url of the image
     - parameter imageView: imageView where the image is loaded
     */
    static func loadNetImage(urlImage:String, imageView: UIImageView){
        
        if let url = URL(string: urlImage){
        ImageUtils.lazyLoadFromUrl(url: url, imageView: imageView)
        }
        
    }
    
}
