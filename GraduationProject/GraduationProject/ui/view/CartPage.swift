//
//  CartPage.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 9.04.2024.
//

import UIKit

class CartPage: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelPrice: UILabel!
    
    var cartList = [Cart]()
    var viewModel = CartPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        _ = viewModel.cartList.subscribe(onNext: { list in
            self.cartList = list
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        

        
        barBackButton()
    }
    
    func barBackButton() {
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(named: "color2")
        
    }
}

extension CartPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cart = cartList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cart.yemek_resim_adi!)") {
             DispatchQueue.main.async {
                 cell.imageViewOrder.kf.setImage(with: url)
             }
        }
        
        cell.labelName.text = cart.yemek_adi
        cell.labelPrice.text = "\(cart.yemek_fiyat!) ₺"
        cell.labelCount.text = "\(cart.yemek_siparis_adet!)"

        return cell
    }
}
