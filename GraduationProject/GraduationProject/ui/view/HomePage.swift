//
//  ViewController.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 6.04.2024.
//

import UIKit
import Kingfisher

class HomePage: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewMenu: UICollectionView!
    
    var menuList = [Menu]()
    var viewModel = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewMenu.delegate = self
        collectionViewMenu.dataSource = self
        
        _ = viewModel.menuList.subscribe(onNext: { list in
            self.menuList = list
            DispatchQueue.main.async {
                self.collectionViewMenu.reloadData()
            }
        })
    
        appearance()
        barButtonItem()
        collectionViewDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.uploadMenu()
    }
    
    // MARK: Funcs
    
    func appearance() {
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(named: "color")
        
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func barButtonItem() {
        
        if let image = UIImage(named: "menu"){
            let originalImage = image.withRenderingMode(.alwaysOriginal)
            
            let button = UIButton(type: .custom)
            button.setImage(originalImage, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            let barButtonItem = UIBarButtonItem(customView: button)
    
            navigationItem.leftBarButtonItem = barButtonItem
        }
        
        if let image = UIImage(named: "cart"){
            let originalImage = image.withRenderingMode(.alwaysOriginal)
            
            let button = UIButton(type: .custom)
            button.setImage(originalImage, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            
            let barButtonItem = UIBarButtonItem(customView: button)
    
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }
    
    func collectionViewDesign() {
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik - 18) / 2
        
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.2)
        
        collectionViewMenu.collectionViewLayout = tasarim
    }
}

// MARK: Extensions

extension HomePage: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let menu = menuList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(menu.yemek_resim_adi!)") {
             DispatchQueue.main.async {
                 cell.imageView.kf.setImage(with: url)
             }
        }
        
        cell.labelName.text = menu.yemek_adi
        cell.labelPrice.text = "\(menu.yemek_fiyat!) ₺"
        
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10.0
        
        return cell
    }
}
