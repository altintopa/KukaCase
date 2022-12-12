//
//  ProductDetailPageViewController.swift
//  KukaCase
//
//  Created by Ahmet ALTINTOP on 12.12.2022.
//

import UIKit

enum productType {
    case mainProduct
    case productDetail
}

class PDPViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var btnBack: NSLayoutConstraint!
    
    var producID = -1
    var url = "https://fakestoreapi.com/products/1"
    var products: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // collectionView.collectionViewLayout = createLayout()
        
        self.collectionView.register(UINib(nibName: "PDPCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PDPCellID")
        self.collectionView.register(UINib(nibName: "PDPProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PDPProductCellID")
    }
    
    func getProduct(){
        guard let url = URL(string: "https://fakestoreapi.com/products/\(producID)") else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if  error != nil {
                print("errror")
            }
            
            guard let data = data else {return}
            
            do {
                let sonuc = try JSONDecoder().decode([ProductModel].self, from: data)
                self.products = sonuc
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("NOO")
            }
            
        }
        task.resume()
    }
    
    @IBAction func btnVack_Tapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension PDPViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      return UICollectionViewCell()
    }
}
