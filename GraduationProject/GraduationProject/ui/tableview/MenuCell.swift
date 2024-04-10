//
//  MenuCell.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 6.04.2024.
//

import UIKit

protocol MenuCellProtocol {
    func clickedAddToCart(indexPath:IndexPath)
}

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    var menuCellProtocol:MenuCellProtocol?
    var indexPath:IndexPath?
    
    @IBAction func buttonAddToCart(_ sender: Any) {
        menuCellProtocol?.clickedAddToCart(indexPath: indexPath!)
    }
}
