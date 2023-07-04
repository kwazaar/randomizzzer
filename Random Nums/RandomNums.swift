//
//  RandomNumsFunc.swift
//  Random Nums
//
//  Created by MaxOS on 04.07.2023.
//

import Foundation
import SwiftUI


struct RandomNumsModel {
    
    
    var randomNums: String
    var randomSize: Int
    var sizeFontMin: Int = 50
    var sizeFontMax: Int = 200
    var minNums: Int = 1
    var maxNums: Int = 100
    
    
    mutating func spinRundomSize () {
        
        self.randomNums = String(Int.random(in: minNums...maxNums))
        self.randomSize = Int.random(in: sizeFontMin...sizeFontMax)
        
    }
    
    
    

}


