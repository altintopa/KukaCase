//
//  ProductListPageViewController.swift
//  KukaCase
//
//  Created by Ahmet ALTINTOP on 12.12.2022.
//

import UIKit

class PLPViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblCategoriTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    var headline: String = ""
    var products : [ProductModel] = []
    var filterCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
        
        setCollectionViewLayout()
        
    }
    
    func reMakeHeadline(){
        switch headline {
        case "Electronics":
            headline = "electronics"
            lblCategoriTitle.text = "Electronics"
        case "Jewelery":
            headline = "jewelery"
            lblCategoriTitle.text = "Jewelery"
        case "Men's clothing":
            headline = "men's%20clothing"
            lblCategoriTitle.text = "Men's clothing"
        case "Women's clothing":
            headline = "women's%20clothing"
            lblCategoriTitle.text = "Women's clothing"
        default:
            headline = "electronics"
            lblCategoriTitle.text = "Electronics"
        }
    }
    
    func getProducts(){
        
        reMakeHeadline()
        
        guard let url = URL(string: "https://fakestoreapi.com/products/category/\(headline)") else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if  error != nil {
                print("asd")
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
    
    
    func setCollectionViewLayout(){
        let width = ( self.view.frame.size.width / 2) - 25
        
        let cellSize = CGSize(width: width, height: 320)

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
  
    
    @IBAction func backButton_Tapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func filterButton_Tapped(_ sender: Any) {
        
        if filterCount == 0 {
            products = products.sorted{ $0.price > $1.price}
            collectionView.reloadData()
            filterCount = 1
            
        } else {
            products = products.sorted{ $0.price < $1.price}
            collectionView.reloadData()
            filterCount = 0
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPDP" {
            let vc = segue.destination as! ProductDetailPageVC
            vc.producID = sender as! Int
            vc.productName = (products[sender as! Int].title)
            vc.allProducts = products
        }
    }
}

extension PLPViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PLPCellID", for: indexPath) as! PLPCollectionViewCell
        cell.setupCell(item: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPDP", sender: indexPath.row)
    }

    
}
