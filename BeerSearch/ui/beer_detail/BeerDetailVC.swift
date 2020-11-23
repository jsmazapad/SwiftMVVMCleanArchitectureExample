//
//  BeerDetailVC.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit

class BeerDetailVC:ParentVC{
    
    var element:Beer?
    var viewModel:BeerDetailVM = BeerDetailVM()
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var foodsLabel:UILabel!
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var ABVLabel: UILabel!
    
    override func viewDidLoad() {
        if let element = element{
            titleLabel.text = element.name
            descriptionLabel.text = element.beerDescription
            viewModel.loadImage(imageUrl: element.imageUrl, imageView: imageIV)
            foodsLabel.text = viewModel.getFoodsAsText(foods: element.foodPairing)
            var ABVText = "Not determined"
            if let ABVLevel = element.ABVLevel{
                ABVText = "\(ABVLevel)"
            }
            ABVLabel.text = ABVText
        }
    }
    
    
}
