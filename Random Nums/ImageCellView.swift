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
                .background(.gray)
                .frame(width: UIScreen.main.bounds.width / 4 , height: UIScreen.main.bounds.height / 4)
                .cornerRadius(20)
        }
    }
}

//struct ImageCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCellView(image: image)
//    }
//}
