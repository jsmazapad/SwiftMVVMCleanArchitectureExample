import Foundation
import UIKit
import Bond

class ParentTableViewVC <T>: ParentVC, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate{
    
    var headerView:UIView!
    var tableViewHolder:UITableView?
    var cellIdentifier: String!
    let refreshControl = UIRefreshControl()
    var viewModel:ParentTableViewVM<T>!
    
    override func viewDidLoad() {
        configureAdditionalViews()
        
        configureBinding()
        
        if #available(iOS 10.0, *) {
            tableViewHolder?.refreshControl = refreshControl
        } else {
            tableViewHolder?.addSubview(refreshControl)
        }
        tableViewHolder?.delegate = self
        tableViewHolder?.dataSource = self
        tableViewHolder?.tableFooterView = UIView(frame: .zero)
        
        refreshControl.addTarget(self, action: #selector(updateElements(_:)), for: .valueChanged)
        refreshControl.refreshManually()
        self.tableViewHolder?.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.size.height), animated: true)
        
        
        tableViewHolder?.rowHeight = UITableView.automaticDimension
        tableViewHolder?.estimatedRowHeight = 600
        super.viewDidLoad()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!viewModel!.isLoading.value){
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
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ParentTableViewCellProtocol = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as! ParentTableViewCellProtocol
        cell.fillCell(element: viewModel.elements.value[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
    }
    
    /**
     Calls viewmodel to update elements
     */
    @objc func updateElements(_ sender: Any) {
        
        self.viewModel.loadData()
    }
    
    /**
     Configures additional views
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
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    
}
