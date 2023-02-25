//
//  LoginTableViewController.swift
//  LoginUI
//
//  Created by Apple on 04/11/1944 Saka.
//

import UIKit
import FirebaseAuth
//import FirebaseFirestore
//import Firebase


class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        if Auth.auth().currentUser == nil {
//          // User is signed in.
//            
//        } else {
//          // No user is signed in.
//            let containerVC = ContainerController()
//            self.view.addSubview(containerVC.view)
//            self.addChild(containerVC)
//            self.didMove(toParent: self)
//        }
//    
//}
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        
        validationCode()
        
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        
        if let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController{
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
        
    }
    
    
    
}

extension LoginTableViewController{
    fileprivate func validationCode() {
        if let email = txtEmail.text , let password = txtPassword.text{
            
            if !email.validateEmailID(){
                openAlert(title: "Alert", message: "Email Address not found", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                                                                                                                                                                print("Okay Clicked!")}])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Password is not valid", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                                                                                                                                                                print("Okay Clicked!")}])
                
            }else{
               // navigation - HomeScreen
                
                
                AuthService.logIn(email: email, password: password) { error in
                    if error != nil{
                        print("Couldn't sign in!")
                    }else{
                        print("Login Success")
                        
                        let containerVC = ContainerController()
                        self.view.addSubview(containerVC.view)
                        self.addChild(containerVC)
                        self.didMove(toParent: self)
                        
                        
                    }
                }
                          }
            
        }else{
            openAlert(title: "Alert", message: "Please add details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                print("Okay Clicked!")
            }])
        }
        
    }
}

