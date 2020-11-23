//
//  BeersVC.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit

class BeersVC:ParentTableViewVC<Beer>, UITextFieldDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextTF: UISearchBar!
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var ABVLabel: UILabel!
    @IBOutlet weak var ABVSlider: UISlider!
    
    var selectedElementId:Int = -1
    let pickerViewProvinces = UIPickerView()
    
    override func viewDidLoad() {
        
        self.tableViewHolder = tableView
        
        viewModel = BeersVM(tableview: self.tableViewHolder!)
        
        ABVSlider.maximumValue = ConfigConstants.ABVMaximumLevel
        ABVSlider.minimumValue = 0
        ABVSlider.value = 0
        
        self.cellIdentifier = BeerCell.identifierForReuse
        
        super.viewDidLoad()
    }
    
    /**
    MARK: - TableView
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let element = places[indexPath.row]
        self.selectedElementId = indexPath.row
        self.performSegue(withIdentifier: "showBeerDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBeerDetail"
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
    
    /**
        MARK: - Gesture Recognizers
        */
    
    @objc func handleTapPreviousButton(_ sender: UITapGestureRecognizer? = nil) {
        (viewModel as! BeersVM).loadPreviousPage()
    }

    @objc func handleTapNextButton(_ sender: UITapGestureRecognizer? = nil) {
        (viewModel as! BeersVM).loadNextPage()
    }
    
    
}

