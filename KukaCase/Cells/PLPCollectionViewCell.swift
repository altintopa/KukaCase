//
//  PLPCollectionViewCell.swift
//  KukaCase
//
//  Created by Ahmet ALTINTOP on 12.12.2022.
//

import UIKit

class PLPCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblProductDetail: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(item: ProductModel){
        lblProductPrice.text = "\(item.price) €"
        lblProductDetail.text = item.description
        productImage.load(url: URL(string: item.image)!)
        
    }

}

extension UIImageView {   /// API'den gelen imageURL'i teşhir etmek için . .
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
