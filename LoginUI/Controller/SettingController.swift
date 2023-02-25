//
//  SettingController.swift
//  LoginUI
//
//  Created by Apple on 14/11/1944 Saka.
//

import UIKit

class SettingController : UIViewController{
    
    //MARK: - Properties

    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Helper Functions
    func configureUI(){
        view.backgroundColor = .blue

        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .actions , style: .plain, target: self, action: #selector(handleDismiss) )
    }

}
