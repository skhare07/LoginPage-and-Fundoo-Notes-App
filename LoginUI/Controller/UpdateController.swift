//
//  UpdateController.swift
//  LoginUI
//
//  Created by Apple on 15/11/1944 Saka.
//
import UIKit
import UserNotifications

//import FirebaseFirestore


class UpdateController : UIViewController{
    
    //let db = Firestore.firestore()
    
    var selectedNote : Note?
    
    
    
    @IBOutlet weak var descriptionTextField: UITextField!
   
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = selectedNote?.title
        descriptionTextField.text = selectedNote?.description
        configureNavigationController()
    }
    
    @IBAction func updateReminderBtn(_ sender: UIButton) {
        guard let addReminderController = storyboard?.instantiateViewController(identifier: "AddReminder") as? AddReminder else {
            return
        }
        
        
        navigationController?.pushViewController(addReminderController, animated: true)
            addReminderController.title = "New Reminder"
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge, .sound],completionHandler:  { success, error in
            if success {
                //schedule test
                //self.scheduleNotification()
               
                addReminderController.completion = { date in
                    DispatchQueue.main.async {
                       
                        
                        //content
                        let content = UNMutableNotificationContent()
                        
                        content.title = self.titleTextField.text!
                        content.sound = .default
                        content.body = self.descriptionTextField.text!
                        
                        //trigger
                        let targetDate = date
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month , .day , .hour , .minute , .second], from: targetDate), repeats: false)
                        
                        //request
                        
                        let request = UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request) { error in
                            if error != nil{
                                print("Something went wrong")
                            }
                        }
                    }
                }
                
                
            }else if let error = error {
                print("Error occured")
            }
        })
   }
    
       
    
    @IBAction func updateButton(_ sender: UIButton) {
        
        

        if let title = titleTextField.text , let description = descriptionTextField.text , let id = selectedNote?.id{
        
          //  let date = addReminderVC.datePicker.date
            
            let newData :[String : Any] = ["title":title , "description": description  , "id": id /*,"reminder":date */ ]
            
            NoteService.updatingNote(newData: newData, id: id){  error in
                if error != nil {
                    print("Error: \(error?.localizedDescription)")
                    
                }
                
//
//            db.collection("notes").document(id).setData(newData) { error in
//                if error != nil {
//                    print("Error: \(error?.localizedDescription)")
//
//                }
                else{
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            
                
                
            }
        }
        
        
    }
   
    @objc func deleteNote(){
        if let id = selectedNote?.id {
            NoteService.deletingNote(id: id) {error in
                    if error != nil{
                        return
                    }
                
            }
            //UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
           
            navigationController?.popViewController(animated: true)
        }
    }

    
    func configureNavigationController(){
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Update"
     
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Delete" , style: .plain, target: self, action: #selector(deleteNote))
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        
    }
    
}
