//
//  SignupViewController.swift
//  LoginUI
//
//  Created by Apple on 06/11/1944 Saka.
//

import UIKit

class SignupViewController: UITableViewController {

   
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
  
    
    @IBOutlet weak var txtConPassword: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)) )

        imgProfile.isUserInteractionEnabled = true
        imgProfile.addGestureRecognizer(tapGesture)
       
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("Image Tapped!")
        openGallery()
         
        
        
    }
    
    fileprivate func userValidation() {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
        
        if imgProfile.image?.pngData() != imgSystem?.pngData(){
            //profile image selected
            
            if let email = txtEmail.text,let username = txtUsername.text,let password = txtPassword.text,let conPassword = txtConPassword.text{
                if username == ""{
                    print("Enter Username")
                    openAlert(title: "Alert", message: "Please enter Username", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                        print("Okay clicked!")
                    }])
                }else if !email.validateEmailID(){
                    print("Email is not valid")
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                        print("Okay clicked!")
                    }])
                }else if !password.validatePassword(){
                    print("Password is not valid")
                    openAlert(title: "Alert", message: "Please enter valid Password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                        print("Okay clicked!")
                    }])
                }else{
                    if conPassword == "" {
                        print("Please confirm Password")
                        openAlert(title: "Alert", message: "Please confirm Password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                            print("Okay clicked!")
                        }])
                    }else{
                        if password == conPassword{
                            //navigation code
                            print("before create user")
                           
                            AuthService.signIn(email: email, password: password, username: username) { error in
                                if error != nil {
                                    
                                print("Error creating user")
                                    return
                                }
                                
                                self.navigationController?.popViewController(animated: true)
                            }
                            
                            
                            print("After create user")
                            
                            
                        }else{
                            print("Password does not match")
                            openAlert(title: "Alert", message: "Password does not match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                                print("Okay clicked!")
                            }])
                        }
                    }
                }
            }else{
                print("Please check your details")
                openAlert(title: "Alert", message: "Please check your details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                    print("Okay clicked!")
                }])
            }
        }else{
            print("Please select profile picture")
            openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                print("Okay clicked!")
            }])
        }
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        userValidation()
      
    }
   
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
}
    
extension SignupViewController : UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker  = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
            
        
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imagepickercontroller")
        if let img = info[.originalImage] as? UIImage {
            imgProfile.image = img
    
        }
        dismiss(animated: true)
        
        
    }
    
    
}


