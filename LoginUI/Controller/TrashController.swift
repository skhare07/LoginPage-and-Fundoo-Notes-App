//
//  TrashController.swift
//  LoginUI
//
//  Created by Apple on 04/12/1944 Saka.
//

import Foundation
import UIKit
import Firebase
class TrashController : UIViewController{
    
    var tableView : UITableView!
    var notesArray = [Note]()
    let db = Firestore.firestore()
    var isDeleted : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationControllerBar()
        showTrash()
    }

    func showTrash(){
        db.collection("notes").getDocuments { snapShot, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            snapShot!.documentChanges.forEach { change in
                
                let document = change.document
                let dataDictionary = document.data()
                
                let title = dataDictionary["title"] as? String ?? ""
                let description = dataDictionary["description"] as? String ?? ""
                let id = document.documentID
                let note = Note(title: title, description: description, id: id)
                let isDeleted = dataDictionary["isDeleted"] as? Bool ?? false
                guard isDeleted else {
                    return
                }
                self.notesArray.append(note)

                }
            self.tableView.reloadData()
    }
}
    func configureTableView(){
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
   
}
    func navigationControllerBar(){
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Trash"
    }
    
    
}

extension TrashController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        let model = notesArray[indexPath.row]
        cell.textLabel?.text = model.title
        
        return cell

    }
    
    
    
}
