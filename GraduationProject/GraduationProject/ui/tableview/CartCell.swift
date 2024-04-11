//
//  CartCell.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 9.04.2024.
//

import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak var imageViewOrder: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel = CartPageViewModel()
    
    var count = 0 {
        didSet {
            labelCount.text = "\(count)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for view in stackView.arrangedSubviews {
            view.widthAnchor.constraint(equalToConstant: 45).isActive = true
        }
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func buttonDecrease(_ sender: Any) {
        count = max(0, count - 1)
    }
    
    @IBAction func buttonIncrease(_ sender: Any) {
        count += 1
    }
}
