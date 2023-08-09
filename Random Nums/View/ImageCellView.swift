//
//  ImageCellView.swift
//  Random Nums
//
//  Created by MaxOS on 17.07.2023.
//

import SwiftUI

struct ImageCellView: View {
    
    @Binding var image: UIImage
    
    var body: some View {
        
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .background(.gray)
                .cornerRadius(10)
        }
    }
}
