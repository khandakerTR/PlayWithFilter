//
//  CustomCollectionViewCell.swift
//  PlayWithFilter
//
//  Created by Tushar Khandaker on 7/20/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.imageView.layer.borderWidth = 2
                self.imageView.layer.borderColor = UIColor.red.cgColor
                
            } else {
                self.imageView.layer.borderWidth = 0
            }
        }
    }
}
