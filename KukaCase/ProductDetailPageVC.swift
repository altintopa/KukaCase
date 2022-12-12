//
//  ProductDetailPageVC.swift
//  KukaCase
//
//  Created by Ahmet ALTINTOP on 12.12.2022.
//

import UIKit

class ProductDetailPageVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblProduct: UILabel!
    
    var producID = -1
    var allProducts: [ProductModel] = []
    var productName = ""
    var selectedProduct: [ProductModel] = []
    var releatedProducts: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "PDPCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PDPCellID")
        self.collectionView.register(UINib(nibName: "PDPProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PDPProductCellID")
        //getProduct()
        collectionView.collectionViewLayout = createLayout()
        lblProduct.text = productName
    }
    
    func setProduct(){
        
        for product in self.allProducts {
//                while product.category == self.productCat {
//                    self.releatedProducts.append(product)
//                }
            
            if product.id == self.producID {
                self.selectedProduct.append(product)
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func getProduct(){
        guard let url = URL(string: "https://fakestoreapi.com/products") else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if  error != nil {
                print("errror")
            }
            
            guard let data = data else {return}
            
            do {
                let sonuc = try JSONDecoder().decode([ProductModel].self, from: data)
                self.allProducts = sonuc
                self.setProduct()
                
            } catch {
                print("NOO")
            }
            
        }
        task.resume()
    }
    
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
       UICollectionViewCompositionalLayout  { [weak self] sectionIndex, layoutEnvironment in
           guard let self = self else { return nil }
           
           if self.allProducts.count != 0 {
               let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

               
               let width = self.view.frame.size.width
               let height = self.view.frame.size.height * 0.7

               let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(width), heightDimension: .absolute(height)), subitems: [item])

               
               let section = NSCollectionLayoutSection(group: group)
               section.orthogonalScrollingBehavior = .continuous
               section.interGroupSpacing = 7
               section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
               section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
               
               return section
               
           } else {
               let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

               
               let width = (self.view.frame.size.width / 2 ) - 35
               let height = self.view.frame.size.height

               let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(width), heightDimension: .absolute(height)), subitems: [item])

               
               let section = NSCollectionLayoutSection(group: group)
               section.orthogonalScrollingBehavior = .continuous
               section.interGroupSpacing = 7
               section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
               section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]

               return section
           }
       }
   }
    
    @IBAction func btnBack_Tapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
 

extension ProductDetailPageVC : UICollectionViewDataSource , UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return self.selectedProduct.count
//        } else {
//            return self.allProducts.count
//        }
        
        return self.allProducts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDPCellID", for: indexPath) as! PDPCollectionViewCell
            cell.setupCell(item: allProducts[indexPath.row])
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDPProductCellID", for: indexPath) as! PDPProductsCollectionViewCell
            cell.setupCell(item: allProducts[indexPath.row])
            return cell
        }
    }
    
    
}
