//
//  RandomNumViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 04.07.2023.
//

import Foundation



class RandomNumViewModel: ObservableObject {
    
    @Published var randomNums: RandomNumsModel
    

    
    init(randomNums: RandomNumsModel) {
        self.randomNums = randomNums
    }

    
    func spinRundomSize () {
        
        randomNums.randomNum = String(Int.random(in: randomNums.minNums...randomNums.maxNums))
        randomNums.randomSize = Int.random(in: randomNums.sizeFontMin...randomNums.sizeFontMax)
        
    }
    func chekSizeNums () {
        
        if randomNums.maxNums >= 9999 {
            randomNums.sizeFontMax = randomNums.sizeFontMax / 2
        } else {
            randomNums.sizeFontMax = 150
        }
    }
    
    static let shared = RandomNumsModel()
    


    
}
