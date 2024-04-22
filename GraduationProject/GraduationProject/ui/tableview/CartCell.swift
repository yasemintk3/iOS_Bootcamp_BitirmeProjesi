//
//  CartCell.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 9.04.2024.
//

import UIKit

protocol CartCellProtocol {
    func clickedCount(indexPath: IndexPath, count: Int)
}

class CartCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageViewOrder: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelCount: UILabel!
    
    var cartCellProtocol: CartCellProtocol?
    var indexPath: IndexPath?

    var count = 0
    
    // MARK: - Funcs
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buttonDecrease(_ sender: Any) {
        count = Int(labelCount.text!)!
        
        if count > 1 {
            count -= 1
            cartCellProtocol?.clickedCount(indexPath: indexPath!, count: count)
        }
    }
    
    @IBAction func buttonIncrease(_ sender: Any) {
        count = Int(labelCount.text!)!
        
        count += 1
        cartCellProtocol?.clickedCount(indexPath: indexPath!, count: count)
    }
}
