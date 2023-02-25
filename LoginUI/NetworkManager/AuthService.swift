//
//  AuthService.swift
//  LoginUI
//
//  Created by Apple on 27/11/1944 Saka.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct AuthService {
    
    static func logIn(email:String , password:String ,completion: @escaping (Error?) -> (Void) ){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(error)
        }
    }
    
    static func signIn(email:String , password:String ,username: String,completion: @escaping (Error?) -> (Void) ){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error != nil { completion(error) }
          
            let db = Firestore.firestore()
            guard let uid = result?.user.uid else { return }
          
            
           
            db.collection("users").addDocument(data: ["Username": username, "Email": email,"uid": uid]) { error in
                completion(error)
            }
            
            
        }
    }
        
    static func logOut( completion: @escaping (Bool) -> Void){
       
        
        
        do{
        try Auth.auth().signOut()
        completion(true)
        }catch{
            print(error.localizedDescription)
            completion(false)
        }
        
    }
   
    
 
}
