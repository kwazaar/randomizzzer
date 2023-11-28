//
//  RandomMapModel.swift
//  Random Nums
//
//  Created by MaxOS on 28.07.2023.
//

import Foundation


struct RandomMapModel {
    var range = 2.0
    var randomRangeX: Double {
        return Double(.random(in: -0.45...0.45))
    }
    var randomRangeY: Double {
        return Double(.random(in: -0.45...0.45))
    }
    var multiplierLatitude: Double = 0.009
    var multiplierLongitude: Double = 0.016
    
}


