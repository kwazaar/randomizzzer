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
    
    
    init(randomPhotos: RandomPhotoModel, inputImage: UIImage) {
        self.randomPhotos = randomPhotos
    }
    func spinPhoto () {
        randomPhotos.showImage = randomPhotos.randomImage[randomPhotos.randomPhotoNum]
    }
    
    static let shared = RandomPhotoModel()

}
