//
//  ModalMessage.swift
//  BeerSearch
//
//  Created by Joaquin Sainz de la Maza on 2020-11-07.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import Foundation
import UIKit

class ModalMessage{
    
    public static func showModalMessage(viewController:UIViewController, title:String, message:String, buttonOkLabel:String?, buttonOkHandler:((UIAlertAction) -> Void)? = nil, buttonCancelLabel:String?, buttonCancelHandler:((UIAlertAction) -> Void)? = nil  ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var okLabel = NSLocalizedString("default.modal.okButton", comment: "")
        if let buttonOkLabel = buttonOkLabel
        {
            okLabel = buttonOkLabel
        }
        
        alert.addAction(UIAlertAction(title: okLabel, style: .default, handler:buttonOkHandler))
        
        if buttonCancelLabel != nil || buttonCancelHandler != nil
        {
            var cancelLabel = NSLocalizedString("default.modal.cancelButton", comment: "")
            if let buttonCancelLabel = buttonCancelLabel{
                cancelLabel = buttonCancelLabel
            }
            alert.addAction(UIAlertAction(title: cancelLabel, style: .default, handler: buttonCancelHandler))
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public static func showError(viewController:UIViewController, message:String, buttonOkLabel:String?, buttonOkHandler:((UIAlertAction) -> Void)? = nil, buttonCancelLabel:String?, buttonCancelHandler:((UIAlertAction) -> Void)? = nil)
    {
        self.showModalMessage(viewController:viewController, title:NSLocalizedString("error.modal.title", comment: ""), message:message, buttonOkLabel:buttonOkLabel, buttonOkHandler:buttonOkHandler, buttonCancelLabel:buttonCancelLabel, buttonCancelHandler:nil)
    }
}

