//
//  RandomMapViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 28.07.2023.
//

import Foundation
import MapKit


class RandomMapViewModel: ObservableObject {
    
    @Published var randomMap: RandomMapModel
    
    @Published var coordinate = [Items]()
    
    init(randomMap: RandomMapModel) {
        self.randomMap = randomMap
    }
    
    
    static let shared = RandomMapModel()
    
}
