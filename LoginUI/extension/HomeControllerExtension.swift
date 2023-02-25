//
//  HomeControllerExtension.swift
//  LoginUI
//
//  Created by Apple on 26/11/1944 Saka.
//

import Foundation
import UIKit

extension HomeController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return filterData.count
        }
        return notesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.identifier, for: indexPath) as! NoteCollectionViewCell
        if searching{
            
            cell.myLabel.text = filterData[indexPath.row].title
            
        }else{
            cell.myLabel.text = notesArray[indexPath.row].title
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        let updateVC = storyboard.instantiateViewController(identifier: "UpdateController") as! UpdateController

        updateVC.selectedNote = notesArray[indexPath.row]

        self.navigationController?.pushViewController(updateVC, animated: true)

        print("selected index : \(indexPath.row)")

    }
    
    
    //collectionviewdelegateflowlayout
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > (collectionView.contentSize.height-100-scrollView.frame.size.height) {
        
            fetchMoreNotes()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      //  print("called collectionview delegate")
        let width = gridview ? (view.frame.size.width)-4 : (view.frame.size.width/2)-4
        let height = gridview ? 100 : (view.frame.size.width/2)-4
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 0, bottom: 0, right: 0)
    }
    
    
    
}



extension HomeController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filterData = notesArray
        }else{
            
            filterData = notesArray.filter({($0.title?.lowercased().contains(searchText.lowercased()))!  })
            
            
        }
        print("list:", filterData)
        searching = true
        self.collectionView.reloadData()
       // self.tableView.reloadData()
    }
    
}
