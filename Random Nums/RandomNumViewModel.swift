//
//  RandomNumViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 04.07.2023.
//

import Foundation



class RandomNumViewModel: ObservableObject {
    @Published var randomNums: RandomNumsModel
    static let shared = RandomNumsModel(randomNums: "0", randomSize: 10)
    
    init(randomNums: RandomNumsModel) {
        self.randomNums = randomNums
    }
}
