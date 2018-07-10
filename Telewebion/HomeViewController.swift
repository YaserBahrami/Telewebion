//
//  HomeViewController.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    @IBOutlet weak var dataCollectionView: UICollectionView!
    let realm = try! Realm()
    var collectionData = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update(page: 0)
        dataCollectionView.dataSource = self
        dataCollectionView.delegate = self
        dataCollectionView.register(programCollectionViewCell.self)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.dataCollectionView.addGestureRecognizer(lpgr)
        
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let point = gestureReconizer.location(in: self.dataCollectionView)
        let indexPath = self.dataCollectionView.indexPathForItem(at: point)
        
        if let index = indexPath {
            let alertActionCell = UIAlertController(title: "عملیات", message: "نوع عملیات مورد نظر را انتخاب نمایید", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "ذخیره", style: .default, handler: { action in
                
                
                let realmModel = RealmDataModel()
                realmModel.title = self.collectionData[index.row].title!
                realmModel.picture_path = self.collectionData[index.row].picture_path!
                realmModel.programTitle = self.collectionData[index.row].programTitle!
                
                
                
                try! self.realm.write {
                    self.realm.add(realmModel, update: true)
                }
                
                
                print("Cell Saved")
                
            })
            
            // Configure Cancel Action Sheet
            let cancelAction = UIAlertAction(title: "لغو", style: .cancel, handler: { acion in
                print("Cancel actionsheet")
            })
            
            alertActionCell.addAction(deleteAction)
            alertActionCell.addAction(cancelAction)
            self.present(alertActionCell, animated: true, completion: nil)
//            print(index.row)
        } else {
            print("Could not find index path")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(at: indexPath) as programCollectionViewCell
        
        if collectionData.count > 0{
            cell.title.text = collectionData[indexPath.row].title
            cell.programTitle.text = collectionData[indexPath.row].programTitle
            
            
            Alamofire.request(collectionData[indexPath.row].picture_path!).responseData(completionHandler: { (response) in
                if response.error == nil{
                    let img = UIImage(data: response.data!)
                    cell.picture.image = img
                }
            }).validate(contentType: ["image/*"])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 100)
        
    }
    
    var pageCounter = 0
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print(indexPath.row)
        print(collectionData.count)
        if indexPath.row == collectionData.count - 1{
            pageCounter += 1
            update(page: pageCounter)
        }
    }
    func update(page: Int){
        let shared = WebService.shared
        shared.getNewestPrograms(page: page) { (result) in
            switch result{
            case .success(let value):
                self.collectionData += value
            case .failure:
                print("error")
            }
            
            self.dataCollectionView.reloadData()
        }
    }
    
}

