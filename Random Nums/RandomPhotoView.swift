//
//  RandomPhotoView.swift
//  Random Nums
//
//  Created by MaxOS on 13.07.2023.
//

import SwiftUI

struct RandomPhotoView: View {
    
    @State private var isShowGalery = false
    @State private var isShowCamera = false
    @State var inputImage = UIImage()
    @State var randomImage = [UIImage]()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        VStack() {
            Button("Вернуться в меню") {
                self.dismiss()
            }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
            Spacer()
            ScrollView(.horizontal){
                LazyHStack() {
                    Text("Загруженные\nизображения:")
                    if !randomImage.isEmpty {
                        ForEach(0..<randomImage.count, id: \.description) { item in
                            ImageCellView(image: $randomImage[item])
                        }
                    }
                }
                
                .frame(height: 100)
                
            }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
            VStack {
                VStack {
                    Button("Выбрать фото из галереи") {
                        isShowGalery.toggle()
                    }
                    .sheet(isPresented: $isShowGalery) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$inputImage)
                    }
                    .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                    .foregroundColor(.black)
                    .background(Capsule().stroke(.black, lineWidth: 2))
                    
                    Button("Сделать фото") {
                        isShowCamera.toggle()
                    }
                    .sheet(isPresented: $isShowCamera) {
                        ImagePicker(sourceType: .camera, selectedImage: self.$inputImage)
                    }
                    .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                    .background(Capsule().stroke(.black, lineWidth: 2))
                    .foregroundColor(.black)

                }
                .onChange(of: inputImage) { newValue in
                    randomImage.append(newValue)
                }
//                Button
            }
        }
    }
    
}


struct RandomPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RandomPhotoView()
    }
}
