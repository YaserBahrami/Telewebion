//
//  FavoritesViewController.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var FavCollectionView: UICollectionView!
    
    var FavData = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRealmData()
        
        FavCollectionView.dataSource = self
        FavCollectionView.delegate = self
        FavCollectionView.register(programCollectionViewCell.self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadRealmData(){
        FavData.removeAll()
        let realm = try! Realm()
        let list = realm.objects(RealmDataModel.self)
        print(list.count)
        for model in list{
            let temp = DataModel()
            temp.realmMapper(realmData: model)
            FavData.append(temp)
        }
        self.FavCollectionView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        loadRealmData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(at: indexPath) as programCollectionViewCell
        
        if FavData.count > 0{
            cell.title.text = FavData[indexPath.row].title
            cell.programTitle.text = FavData[indexPath.row].programTitle
            
            
            Alamofire.request(FavData[indexPath.row].picture_path!).responseData(completionHandler: { (response) in
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
    
}

