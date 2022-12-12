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

class ProductDetailPageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var btnBack: NSLayoutConstraint!
    
    var producID: Int = -1
    var url = "https://fakestoreapi.com/products/1"
    var products: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.collectionView.register(UINib(nibName: "PDPCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PDPCellID")
        self.collectionView.register(UINib(nibName: "PDPProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PDPProductCellID")
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout  { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else {return nil }
            
            if self.products[sectionIndex].id == producID {
                let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                // Group
                let width = self.view.frame.size.width
                let height = 400
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(width), heightDimension: .absolute(height)), subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 7
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                
                return section
                
            } else {
                let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                // Group
                let width = ( self.view.frame.size.width / 2 ) - 35
                let height = (320)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(width), heightDimension: .absolute(height)), subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                
                return section
            }
            
        }
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
extension ProductDetailPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDPCellID", for: indexPath) as! PDPCollectionViewCell
            cell.setupCell()
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDPProductCellID", for: indexPath) as! PDPProductsCollectionViewCell
            cell.setupCell()
            return cell
        }
    }
}
