//
//  DetailPage.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 7.04.2024.
//

import UIKit
import Kingfisher

class DetailPage: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var labelCount: UILabel!
    
    var itemOnTheMenu:Menu?
    var viewModel = DetailPageViewModel()
    
    var count = 0 {
        didSet {
            labelCount.text = "\(count)"
        }
    }
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = itemOnTheMenu {
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(item.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.imageView.kf.setImage(with: url)
                }
            }
            
            labelProductName.text = item.yemek_adi
            labelProductPrice.text = "\(item.yemek_fiyat!) ₺"
        }
        
        for view in stackView.arrangedSubviews {
            view.widthAnchor.constraint(equalToConstant: 35).isActive = true
        }
        navigationControllerAppearance()
    }

    // MARK: - Funcs
    
    func showToast(orderName:String) {

        let alertController = UIAlertController(title: nil, message: "\(orderName) added to cart", preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    func showToast() {

        let alertController = UIAlertController(title: nil, message: "There must be at least 1 product", preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    func navigationControllerAppearance() {
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem?.tintColor = .white
    }

    @IBAction func buttonDecrease(_ sender: Any) {
        count = max(0, count - 1)
    }
    
    @IBAction func buttonIncrease(_ sender: Any) {
        count += 1
    }
    
    @IBAction func buttonAddToCart(_ sender: Any) {
        
        if let item = itemOnTheMenu {
            if count >= 1 {
                viewModel.addToCart(yemek_adi: item.yemek_adi!,
                                    yemek_resim_adi: item.yemek_resim_adi!,
                                    yemek_fiyat: Int(item.yemek_fiyat!)!,
                                    yemek_siparis_adet: Int(count),
                                    kullanici_adi: "ytok")
                
                showToast(orderName: item.yemek_adi!)
            } else {
                showToast()
            }
        }
    }
}
