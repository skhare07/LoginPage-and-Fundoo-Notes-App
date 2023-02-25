//
//  MenuOptions.swift
//  LoginUI
//
//  Created by Apple on 13/11/1944 Saka.
//

import UIKit
enum MenuOption: Int , CustomStringConvertible{
    
    case Profile
    case Inbox
    case Notification
    case Settings
    case Trash
    case Logout
    
    var description : String{
        switch self {
        
        case .Profile:
            return "Profile"
        case .Inbox:
            return "Inbox"
        case .Notification:
            return "Notification"
        case .Settings:
            return "Settings"
        case .Trash:
            return "Trash"
        case .Logout:
            return "Logout"
        }
        
    }
 
    var image: UIImage {
        switch self {
        
        case .Profile:
            return UIImage(named: "person.crop.square") ?? UIImage()
        case .Inbox:
            return UIImage(named: "square.grid.3x1.folder.badge.plus") ?? UIImage()
        case .Notification:
            return UIImage(named: "bell.circle.fill") ?? UIImage()
        case .Settings:
            return UIImage(named: "circles.hexagonpath") ?? UIImage()
        case .Trash:
            return UIImage(named: "trash") ?? UIImage()
        case .Logout:
            return UIImage(named: "arrow.right.doc.on.clipboard" ) ?? UIImage()
    
        }
    }
}
