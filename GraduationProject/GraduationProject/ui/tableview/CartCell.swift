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

    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateLabel() {
        labelCount.text = "\(count)"
    }
    
    @IBAction func buttonDecrease(_ sender: Any) {
        count = Int(labelCount.text!)!
        
        if count > 1 {
            count -= 1
            updateLabel()
        }
    }
    
    @IBAction func buttonIncrease(_ sender: Any) {
        count = Int(labelCount.text!)!
        
        count += 1
        updateLabel()
    }
}
