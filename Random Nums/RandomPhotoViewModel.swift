//
//  RandomPhotoViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 19.07.2023.
//

import Foundation
import SwiftUI

class RandomPhotoViewModel: ObservableObject {
    @Published var randomPhotos: RandomPhotoModel
    @Published var anglePhoto: Double
    
    
    init(randomPhotos: RandomPhotoModel, anglePhoto: Double) {
        self.randomPhotos = randomPhotos
        self.anglePhoto = anglePhoto
    }
    func spinPhoto () {
        randomPhotos.showImage = randomPhotos.randomImage[randomPhotos.randomPhotoNum]
    }
    func rollPhoto () {
        anglePhoto += 360
        if anglePhoto > 10000 {
            anglePhoto = 0
        }
    }
    
    static let shared = RandomPhotoModel()

}
