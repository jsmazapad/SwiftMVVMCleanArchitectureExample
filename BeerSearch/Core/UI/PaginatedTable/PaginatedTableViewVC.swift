//
//  PaginatedTableViewVC.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-24.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import UIKit

class PaginatedTableViewVC<T>:BaseTableViewVC<T>{
    
    /**
        MARK: - Gesture Recognizers
        */
    
    @objc func handleTapPreviousButton(_ sender: UITapGestureRecognizer? = nil) {
        (viewModel as! PaginatedTableViewVM<T>).loadPreviousPage()
    }

    @objc func handleTapNextButton(_ sender: UITapGestureRecognizer? = nil) {
        (viewModel as! PaginatedTableViewVM<T>).loadNextPage()
    }
}
