//
//  ParentTableViewDelegate.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-23.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewDelegate<T>: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var viewModel:BaseTableViewVM<T>
    var cellIdentifier:String
    var headerView:UIView?
    var updateSelectedElementDelegate:TableActionsDelegateProtocol!
    
    init(viewModel:BaseTableViewVM<T>, cellIdentifier:String, headerView:UIView?, updateSelectedElementDelegate: TableActionsDelegateProtocol) {
        self.viewModel = viewModel
        self.cellIdentifier = cellIdentifier
        self.headerView = headerView
        self.updateSelectedElementDelegate = updateSelectedElementDelegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!viewModel.isLoading.value){
            if viewModel.elements.value.count == 0{
                tableView.setEmptyMessage(viewModel.emptyMessage)
            }else{
                tableView.restore()
            }
        }else{
            tableView.restore()
        }
        
        return viewModel.elements.value.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateSelectedElementDelegate.onElementSelected(elementIndex: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BaseTableViewCellProtocol = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCellProtocol
        cell.fillCell(element: viewModel.elements.value[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
}
