//
//  RandomNumViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 04.07.2023.
//

import Foundation



class RandomNumViewModel: ObservableObject {
    
    @Published var randomNums: RandomNumsModel
    @Published var num: Int
    @Published var arrayNums = [Int]()
    let number: String
    

    
    init(randomNums: RandomNumsModel, num: Int, number: String) {
        self.randomNums = randomNums
        self.num = num
        self.number = number
    }

    
    func spinRundomSize () {
        
        num = randomNums.randomNum
        randomNums.randomSize = Int.random(in: randomNums.sizeFontMin...randomNums.sizeFontMax)
        arrayNums.insert(num, at: 0)
        if arrayNums.count > 30 {
            arrayNums.removeLast()
        }
        
        
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
