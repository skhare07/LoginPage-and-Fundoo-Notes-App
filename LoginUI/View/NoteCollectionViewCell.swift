//
//  CustomCollectionViewCell.swift
//  LoginUI
//
//  Created by Apple on 26/11/1944 Saka.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    let myLabel: UILabel = {
        var notesArray = [Note]()
       
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()


    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemYellow
        contentView.addSubview(myLabel)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
    }
}
