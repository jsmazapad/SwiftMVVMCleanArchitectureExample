import Foundation
import UIKit
import Bond

protocol TableActionsDelegateProtocol{
    func onElementSelected(elementIndex:Int)
}

class BaseTableViewVC <T>: BaseVC, UIGestureRecognizerDelegate, TableActionsDelegateProtocol{
    
    var headerView:UIView!
    var tableViewHolder:UITableView?
    var cellIdentifier: String!
    let refreshControl = UIRefreshControl()
    var viewModel:BaseTableViewVM<T>!
    var tableViewDelegate:BaseTableViewDelegate<T>!
    var selectedElementId:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBinding()
        configureTableView()
        configureAdditionalViews()
        
        
        
    }
    
    /**
     Configures tableView
     - warning: Be careful overriding this method and always call super
     */
    func configureTableView(){
        if #available(iOS 10.0, *) {
            tableViewHolder?.refreshControl = refreshControl
        } else {
            tableViewHolder?.addSubview(refreshControl)
        }
        tableViewDelegate = getTableViewDelegate()
        tableViewHolder?.delegate = tableViewDelegate
        tableViewHolder?.dataSource = tableViewDelegate
        tableViewHolder?.tableFooterView = UIView(frame: .zero)
        
        refreshControl.addTarget(self, action: #selector(updateElements(_:)), for: .valueChanged)
        refreshControl.refreshManually()
        self.tableViewHolder?.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.size.height), animated: true)
        
        
        tableViewHolder?.rowHeight = UITableView.automaticDimension
        tableViewHolder?.estimatedRowHeight = 600
    }
    
    
    /**
     Calls viewmodel to update elements
     */
    @objc func updateElements(_ sender: Any) {
        
        self.viewModel.loadData()
    }
    
    /**
     Configures additional views needed
     */
    private func configureAdditionalViews(){
        
    }
    
    
    func configureBinding(){
        
        super.configureBinding(viewModel: self.viewModel)
        
        _ = self.viewModel.isLoading.observeNext{
            loading in
            if(!loading)
            {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func getTableViewDelegate()->BaseTableViewDelegate<T>{
        return BaseTableViewDelegate<T>(viewModel:self.viewModel, cellIdentifier:self.cellIdentifier, headerView:self.headerView, updateSelectedElementDelegate: self)
    }
    
    func onElementSelected(elementIndex:Int){
        selectedElementId = elementIndex
    }
    
}
