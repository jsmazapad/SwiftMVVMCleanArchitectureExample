import Foundation
import UIKit

class ParentVC: UIViewController{
    
    override func viewDidLoad() {
        if let _ = self.navigationController
        {
            customizeNavigationBar()
        }
    }
    
    
    func identifyFromNavigationController()->String?{
        
        if let NVController = self.navigationController
        {
            return NVController.restorationIdentifier
        }else{
            return nil
        }
        
    }
    
    func configureBinding(viewModel:ParentVM){
        viewModel.navigationBarTitle.bind(to:self.navigationItem.reactive.title)
    }
    
    func customizeNavigationBar(){
    }
}
