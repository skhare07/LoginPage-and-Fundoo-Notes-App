//
//  UIAlertController Extension.swift
//  LoginUI
//
//  Created by Apple on 05/11/1944 Saka.
//

import Foundation
import  UIKit

extension UIViewController{
    //global alert
    public func openAlert(title: String, message: String, alertStyle:UIAlertController.Style, actionTitles:[String], actionStyles: [UIAlertAction.Style],actions:[((UIAlertAction)->Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
