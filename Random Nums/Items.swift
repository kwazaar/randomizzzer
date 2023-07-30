//
//  Items.swift
//  Random Nums
//
//  Created by MaxOS on 26.07.2023.
//

import Foundation


struct Items: Decodable {
    
    let items : [Coordinate]
    
    struct Coordinate: Decodable {
        
        let lat: Double
        let lon: Double
        let utm: String
        let wsg: String
        
    }
    
}
