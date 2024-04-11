//
//  DetailPage.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 7.04.2024.
//

import UIKit
import Kingfisher

class DetailPage: UIViewController {
    
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
        
        barBackButton()

        
    }
    
    func barBackButton() {
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(named: "color2")
        
    }

    @IBAction func buttonDecrease(_ sender: Any) {
        count = max(0, count - 1)
    }
    
    @IBAction func buttonIncrease(_ sender: Any) {
        count += 1
    }
    
    
    @IBAction func buttonAddToCart(_ sender: Any) {
    }
}
