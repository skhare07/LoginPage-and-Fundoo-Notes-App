//
//  AddNoteViewController.swift
//  LoginUI
//
//  Created by Apple on 14/11/1944 Saka.
//

import UIKit
import UserNotifications


class AddNoteViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var titleDescField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationControllerBar()
        
    }
    
    
    @IBAction func setReminderBtn(_ sender: UIButton) {
        guard let addReminderController = storyboard?.instantiateViewController(identifier: "AddReminder") as? AddReminder else {
            return
        }
        
        
        navigationController?.pushViewController(addReminderController, animated: true)
        addReminderController.title = "New Reminder"
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge, .sound],completionHandler:  { success, error in
            if success {
                //schedule test
                
                addReminderController.completion = { date in
                    DispatchQueue.main.async {
                        
                        
                        //content
                        let content = UNMutableNotificationContent()
                        
                        content.title = self.titleTextField.text!
                        content.sound = .default
                        content.body = self.titleDescField.text!
                        
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
    
    
    func addDummyNotes(){
        for index in 1..<30{
            
            let documentID = String((NSDate.init().timeIntervalSince1970)*1000)
            
            let data: [String: Any] = ["title":"\(index)" ,"description":"\(index)", "id":documentID]
            
            
            NoteService.addingNote(documentID: documentID, data: data) { error in
                if error != nil{
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
    @objc func addNote(){
        
        
        guard let title = titleTextField.text , let description = titleDescField.text else{ return }
        
        let documentID = String((NSDate.init().timeIntervalSince1970)*1000)
        
        
        let data: [String: Any] = ["title":title ,"description":description, "id":documentID ,"isDeleted": false   ]
        
        isAdded = true
        
        NoteService.addingNote(documentID: documentID, data: data) { error in
            if error != nil{
                return
            }
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    
    
    func navigationControllerBar(){
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Notes"
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Save" , style: .plain, target: self, action: #selector(addNote))
        
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        
    }
    
    
}
