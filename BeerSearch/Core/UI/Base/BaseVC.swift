import Foundation
import UIKit

class BaseVC: UIViewController{
    
    override func viewDidLoad() {
        configureViews()
        if let _ = self.navigationController
        {
            customizeNavigationBar()
        }
    }
    
    /**
     Configure views
     */
    func configureViews(){
        
    }
    
    func identifyFromNavigationController()->String?{
        
        if let NVController = self.navigationController
        {
            return NVController.restorationIdentifier
        }else{
            return nil
        }
        
    }
    
    func configureBinding(viewModel:BaseVM){
        viewModel.navigationBarTitle.bind(to:self.navigationItem.reactive.title)
    }
    
    /**
     Customize navigation bar (only if navigation controller is present)
     */
    func customizeNavigationBar(){
    }
}
