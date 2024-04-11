//
//  ViewController.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 6.04.2024.
//

import UIKit
import Kingfisher
import SwiftUI

class HomePage: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewMenu: UICollectionView!
    
    var menuList = [Menu]()
    var viewModel = HomePageViewModel()
    var viewModelCartPage = CartPageViewModel()
    
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

extension HomePage: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        viewModel.search(searchText: searchText)
    }
}

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
        
        cell.layer.cornerRadius = 10
        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        //cell.layer.borderColor = UIColor.darkGray.cgColor
        //cell.layer.borderWidth = 1
        //cell.layer.cornerRadius = 10.0
        
        cell.menuCellProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let menu = menuList[indexPath.row]
        
        performSegue(withIdentifier: "goToDetailPage", sender: menu)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetailPage" {
            if let itemOnTheMenu = sender as? Menu {
                let detailPage = segue.destination as! DetailPage
                detailPage.itemOnTheMenu = itemOnTheMenu
            }
        }
    }
}

extension HomePage: MenuCellProtocol {
    
    func clickedAddToCart(indexPath: IndexPath) {
        
        let menu = menuList[indexPath.row]
        
        viewModelCartPage.addToCart(yemek_adi: menu.yemek_adi!,
                                    yemek_resim_adi: menu.yemek_resim_adi!,
                                    yemek_fiyat: Int(menu.yemek_fiyat!)!,
                                    yemek_siparis_adet: 0,
                                    kullanici_adi: "ytok")
        
        let cartPage = self.storyboard?.instantiateViewController(withIdentifier: "CartPage") as! CartPage
        self.navigationController!.pushViewController(cartPage, animated: true)
    }
}

