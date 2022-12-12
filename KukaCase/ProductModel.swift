//
//  ProductModel.swift
//  KukaCase
//
//  Created by Ahmet ALTINTOP on 12.12.2022.
//

import Foundation

struct ProductModel: Codable {
    var id : Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image : String
    //var rating: Rating
}

struct Rating: Codable {
    var rate : Double
    var count : Int
}


