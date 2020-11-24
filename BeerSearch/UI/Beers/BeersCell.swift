//
//  BeersCell.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit

class BeerCell: UITableViewCell, BaseTableViewCellProtocol{
    
    static var identifierForReuse: String = "BeerCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageIV: UIImageView!
    
    
    func fillCell(element: Any) {
        let elementSpecified = element as! Beer
        nameLabel.text = elementSpecified.name ?? ""
        if let imageUrl = elementSpecified.imageUrl{
        ImagesProvider.loadNetImage(urlImage: imageUrl, imageView: imageIV)
        }
        
    }
    
}

