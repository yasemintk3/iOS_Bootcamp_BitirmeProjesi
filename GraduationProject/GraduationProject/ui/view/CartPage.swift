//
//  CartPage.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 9.04.2024.
//

import UIKit

class CartPage: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelPrice: UILabel!
    
    var cartList = [Cart]()
    var viewModel = CartPageViewModel()
    var orderIds: [String] = []
    var finalPrice = 0
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        _ = viewModel.cartList.subscribe(onNext: { list in
            self.cartList = list
            DispatchQueue.main.async {
                self.updateTotalPrice()
                self.tableView.reloadData()
            }
        })
        tableView.separatorStyle = .none
        
        navigationControllerAppearance()
    }
    
    // MARK: - Funcs
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func showToast(message: String) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    func navigationControllerAppearance() {
        
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func deleteAllOrders() {
        for orderId in orderIds {
            viewModel.deleteOrder(sepet_yemek_id: Int(orderId)!, kullanici_adi: "ytok")
            tableView.reloadData()
        }
    }
    
    func updateTotalPrice() {
        calculateTotalPrice()
        labelPrice.text = "\(finalPrice) ₺"
    }
    
    func calculateTotalPrice() {
        var totalPrice = 0
        
        for cart in cartList {
            let price = Int(cart.yemek_fiyat!)!
            let count = Int(cart.yemek_siparis_adet!)!
            
            totalPrice += count * price
        }
        
        finalPrice = totalPrice
    }
    
    @IBAction func buttonBackHomePage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func buttonDeleteAll(_ sender: Any) {
        deleteAllOrders()
    }
    
    @IBAction func buttonConfirmOrder(_ sender: Any) {
        showToast(message: "Your order has been received")
        deleteAllOrders()
    }
}

// MARK: - Extensions

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
        
        orderIds.append(cart.sepet_yemek_id!)
        
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.systemGray6.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deletion = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
            
            let cart = self.cartList[indexPath.row]
            
            let alert = UIAlertController(title: "Deletion", message: "Should \(cart.yemek_adi!) be deleted?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.viewModel.deleteOrder(sepet_yemek_id: Int(cart.sepet_yemek_id!)!,
                                           kullanici_adi: cart.kullanici_adi!)
            }
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deletion])
    }
}
