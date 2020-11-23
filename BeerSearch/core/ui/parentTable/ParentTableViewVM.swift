import Foundation
import UIKit
import Bond

class ParentTableViewVM<T>:ParentVM, OnRepositoryResponseDelegate{
    
    var emptyMessage:String = NSLocalizedString("default.tableview.empyMessage", comment: "")

    var elements: Observable<Array<T>> = Observable(Array())
    
    var tableviewHolder:Observable<UITableView?> = Observable(nil)
    var repositoryResponse:Observable<Response<T>> = Observable(Response<T>(response:nil, error:nil))
    
    
    init(tableview:UITableView, title:String){
        super.init()
        self.tableviewHolder.value = tableview
        self.navigationBarTitle.value = title
                
    }
    
    /**
     Called when a repository response is obtained
     - parameter response: Array of items retrieved
     - parameter error: error retrieved in case of failure
     */
    func onRepositoryResponse(response: Array<Any>?, error: Error?) {
        if error != nil || response != nil
        {
            isLoading.value = false
            if response != nil && error == nil{
                self.elements.value = processResponse(response: response)
                self.tableviewHolder.value?.reloadData()
                
            }else{
                ModalMessage.showError(viewController: (tableviewHolder.value?.parentViewController)!, message: (error?.localizedDescription ?? NSLocalizedString("error.network", comment: "")) + NSLocalizedString("error.network.ask.retry", comment: ""), buttonOkLabel: nil, buttonOkHandler:  { action in
                    self.loadData()
                    
                }, buttonCancelLabel: NSLocalizedString("default.modal.cancelButton", comment: ""), buttonCancelHandler: nil)
            }
            
        }
        
    }
    /**
    Process response obtained
    - parameter response: Array of items to process
    - parameter returns: Array of typed items processed
    */
    public func processResponse(response: Array<Any>?)-> Array<T>{
        return response as! Array<T>
    }
    
    /**
    Calls to repository for data
    - warning This method must be overridden in order to compile
    */
    func loadData(){
        preconditionFailure("This method must be overridden")
    }
    
    
}
