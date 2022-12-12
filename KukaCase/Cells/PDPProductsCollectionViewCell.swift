//
//  PDPProductsCollectionViewCell.swift
//  KukaCase
//
//  Created by Ahmet ALTINTOP on 12.12.2022.
//

import UIKit

class PDPProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnAddChart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setupCell(item: ProductModel ){
        lblPrice.text = "\(item.price) €"
        lblProductName.text = item.description
        //lblProductName.text = item.title
        productImage.load(url: URL(string: item.image)!)
    }
    
}
