//
//  RandomPhotoView.swift
//  Random Nums
//
//  Created by MaxOS on 13.07.2023.
//

import SwiftUI

struct RandomPhotoView: View {
    
    @State private var isShowGalery = false
    
    var body: some View {
        Button(("Выберать фото из галереи")) {
            isShowGalery.toggle()
        }.sheet(isPresented: $isShowGalery) {
            // Тут надо сделать вызов функции выбора фото
        }
    }
    
}

struct RandomPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RandomPhotoView()
    }
}
