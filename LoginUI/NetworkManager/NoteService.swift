//
//  NoteService.swift
//  LoginUI
//
//  Created by Apple on 27/11/1944 Saka.
//

import Foundation
import FirebaseFirestore

struct NoteService {

    static let db = Firestore.firestore()
    
    static func addingNote(documentID: String , data: [String : Any], completion: @escaping (Error?) -> (Void)){
       
        db.collection("notes").document(documentID).setData(data){ error in
            completion(error)
        }
    }
    
    static func updatingNote(newData: [String : Any] , id: String , completion: @escaping (Error?) -> (Void)){
        db.collection("notes").document(id).setData(newData){ error in
            completion(error)
        }
    }

    static func deletingNote( id: String , completion: @escaping (Error?) -> (Void)){
        db.collection("notes").document(id).updateData(["isDeleted" : true]){ error in
            completion(error)
        }
    }
}
