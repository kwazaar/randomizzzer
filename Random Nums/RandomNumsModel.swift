//
//  RandomNumsFunc.swift
//  Random Nums
//
//  Created by MaxOS on 04.07.2023.
//

import Foundation
import SwiftUI


struct RandomNumsModel {
    
    var randomSize: Int = 30
    var sizeFontMin: Int = 50
    var sizeFontMax: Int = 150
    var minNums: Int = 1
    var maxNums: Int = 100
    var randomNum: Int {
        get { Int.random(in: minNums...maxNums) }
    }
    var intTextFieldMin = 0
    var intTextFieldMax = 0

}


