//
//  BeersVC.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit


class BeersVC:PaginatedTableViewVC<Beer>, UITextFieldDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextTF: UISearchBar!
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var ABVLabel: UILabel!
    @IBOutlet weak var ABVSlider: UISlider!
    
    let segueDetailIdentifier = "showBeerDetail"
    let pickerViewProvinces = UIPickerView()
    
    
    override func configureViews(){
        self.tableViewHolder = tableView
        
        viewModel = BeersVM(tableview: self.tableViewHolder!)
        
        ABVSlider.maximumValue = ConfigConstants.ABVMaximumLevel
        ABVSlider.minimumValue = 0
        ABVSlider.value = 0
        
        self.cellIdentifier = BeerCell.identifierForReuse
    }
    
    override func onElementSelected(elementIndex: Int) {
        super.onElementSelected(elementIndex: elementIndex)
        self.performSegue(withIdentifier: segueDetailIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueDetailIdentifier
        {
            let element = self.viewModel.elements.value[selectedElementId]
            let destination:BeerDetailVC = segue.destination as! BeerDetailVC
            destination.element = element
        }
    }
    
    
    /**
     MARK: - Binding
     */
    override func configureBinding(){
        super.configureBinding()
        
        _ = searchTextTF.reactive.text.observeNext{ value in
            
            (self.viewModel as! BeersVM).performSearch(searchText: value, ABVValue: self.ABVSlider?.value ?? 0.0)
        }
        
        _ = ABVSlider.reactive.value.observeNext{ value in
            
            (self.viewModel as! BeersVM).performSearch(searchText: self.searchTextTF?.text ?? "", ABVValue: value.rounded(toPlaces: 1))
            self.ABVLabel.text = "\(value.rounded(toPlaces: 1))"
        }
        
        
        let tapPreviousButton = UITapGestureRecognizer(target: self, action: #selector(self.handleTapPreviousButton(_:)))
        let tapNextButton = UITapGestureRecognizer(target: self, action: #selector(self.handleTapNextButton(_:)))
        nextPageButton.isUserInteractionEnabled = true
        _ = previousPageButton.addGestureRecognizer(tapPreviousButton)
        
        _ = nextPageButton.addGestureRecognizer(tapNextButton)
        
        _ = (self.viewModel as! BeersVM).firstPage.observeNext{ value in
            self.previousPageButton.isEnabled = !value
        }
        
        _ = (self.viewModel as! BeersVM).lastPage.observeNext{ value in
            self.nextPageButton.isEnabled = !value
        }
        
    }
    
    
    
    
}

