//
//  AddReminder.swift
//  LoginUI
//
//  Created by Apple on 01/12/1944 Saka.
//

import Foundation
import UIKit

class AddReminder: UIViewController {
  
    @IBOutlet weak var datePicker: UIDatePicker!
  
    
    public var completion : ((Date) -> Void)?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    
    }
    
    
    
    
    @objc func didTapSaveButton(){

        let targetDate = datePicker.date
        completion?(targetDate)

        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func navigationControllerBar(){
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = ""
     
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Save" , style: .plain, target: self, action: #selector(didTapSaveButton))
        
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        }
    

}
