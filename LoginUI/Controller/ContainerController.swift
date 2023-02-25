//
//  ContainerController.swift
//  LoginUI
//
//  Created by Apple on 13/11/1944 Saka.
//

import UIKit
import Firebase

class ContainerController : UIViewController{
    
    
    //MARK: - Properties

    var menuController: MenuController!
    var centerController : UIViewController!
    var isExpanded = false
    let db = Firestore.firestore()
    var notesArray = [Note]()
    var isDeleted : Bool = false
    var collectionView : UICollectionView!

    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureHomeController()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool{
        return isExpanded
    }
    
    //MARK: - Handlers
    
    func configureHomeController(){
        let homeController = HomeController()
       
        homeController.delegate = self
       
        centerController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController(){
        if menuController ==  nil {
            //add our menu controller here
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Did add menu controller")
        }
    }
    
    func animatePanel(shouldExpand : Bool,menuOption:MenuOption?){
        if shouldExpand{
            //show menu
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut , animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80

            }, completion: nil)

            
        }else{
            //hide menu
        
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else {return}
                self.didSelectMenuOption(menuOption:menuOption)
            }
        }
        
        animatedStatusBar()
    }
    
    func didSelectMenuOption(menuOption: MenuOption){
        switch menuOption {
        
        case .Profile:
            print("Show Profile")
            
        case .Inbox:
            print("Show Inbox")
            
        case .Notification:
            print("Show Notification")
            
        case .Settings:
            print("Show Settings")
            
            let settingVC = SettingController()
            present(UINavigationController(rootViewController: settingVC), animated: true, completion: nil)
        
        case .Trash:
            print("Show Trash")
           
            db.collection("notes").whereField("isDeleted", isEqualTo: true ).getDocuments { snapShot, error in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                snapShot!.documentChanges.forEach { note in
                    
                    let document = note.document
                    let dataDictionary = document.data()
                    
                    let title = dataDictionary["title"] as? String ?? ""
                    let description = dataDictionary["description"] as? String ?? ""
                    let id = document.documentID
                    let note = Note(title: title, description: description, id: id)
                    let isDeleted = dataDictionary["isDeleted"] as? Bool ?? false
//                    guard isDeleted else {
//                        return
//                    }
                    self.notesArray.append(note)

                    }
                print(self.notesArray)
                DispatchQueue.main.async{
                    self.collectionView?.reloadData()
        }
        }
            
    
        case .Logout :
            print("Logout")
            AuthService.logOut { isLogout in
                if isLogout{
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginTableViewController") as! LoginTableViewController
                    
                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                        fatalError("could not get scene delegate ")
                    }
                    sceneDelegate.window?.rootViewController = loginVC
                    
                }else{
                    //alert
                    print("logout else part")
                }
            }
            
            }
    }
    
    func animatedStatusBar(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut , animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)

    }
}

extension ContainerController : HomeControllerDelegate{
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded{
            configureMenuController()
        }
        
        //if true than false, if false than true
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    

    }
    
         
    
}
