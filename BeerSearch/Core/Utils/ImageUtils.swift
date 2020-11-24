//
//  ImageUtils.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageUtils{
    static func lazyLoadFromUrl(url:URL, imageView: UIImageView){
        imageView.af.setImage(withURL: url)
    }
}
