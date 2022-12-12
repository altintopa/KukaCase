//
//  ViewController.swift
//  KukaCase
//
//  Created by Ahmet ALTINTOP on 12.12.2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categories =  ["Electronics","Jewelery","Men's clothing","Women's clothing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPLP" {
            let vc = segue.destination as! PLPViewController
            vc.headline = categories[sender as! Int]
        }
    }
    
}
extension CategoriesViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CategoriesTableViewCell
        cell.setupCell(name: categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPLP", sender: indexPath.row)
    }
}

