import Foundation
import Bond

@objc protocol OnRepositoryResponseDelegate{
    
    func onRepositoryResponse(response: Array<Any>?, error:Error?)
    
}

class ParentVM:LoadingVM{ 
   
    var navigationBarTitle: Observable<String> = Observable("")
  
}
