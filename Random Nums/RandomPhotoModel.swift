//
//  RandomPhotoModel.swift
//  Random Nums
//
//  Created by MaxOS on 19.07.2023.
//

import Foundation
import SwiftUI

struct RandomPhotoModel {
    var randomImage = [UIImage]()
    var inputImage = UIImage()
    var showImage = UIImage()
    var randomPhotoNum : Int {
        get { Int.random(in: 0..<randomImage.count) }
    }
}
