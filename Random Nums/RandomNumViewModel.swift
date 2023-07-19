//
//  RandomNumViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 04.07.2023.
//

import Foundation
import SwiftUI



class RandomNumViewModel: ObservableObject {
    
    @Published var randomNums: RandomNumsModel
    @Published var num: Int
    @Published var arrayNums = [Int]()
    @Published var angle: Double
    let number: String
    

    
    init(randomNums: RandomNumsModel, num: Int, number: String, angle: Double) {
        self.randomNums = randomNums
        self.num = num
        self.number = number
        self.angle = angle
    }

    func rollNum () {
        angle += 360
        if angle > 10000 {
            angle = 0
        }
    }
    func spinRundomSize () {
        
        num = randomNums.randomNum
        randomNums.randomSize = Int.random(in: randomNums.sizeFontMin...randomNums.sizeFontMax)
    }
    
    func addNumHistroy() {
        
        arrayNums.insert(num, at: 0)
        if arrayNums.count > 30 {
            arrayNums.removeLast()
        }
    }
    
    func chekSizeNums () {
        
        if randomNums.maxNums >= 1000 {
            randomNums.sizeFontMax = randomNums.sizeFontMax / 2
            
        } else if randomNums.maxNums >= 100000 {
            randomNums.sizeFontMax = randomNums.sizeFontMax / 4
        } else {
            randomNums.sizeFontMax = 150
        }
    }
    
    static let shared = RandomNumsModel()
    


    
}
