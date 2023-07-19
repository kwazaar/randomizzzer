//
//  RandomPhotoView.swift
//  Random Nums
//
//  Created by MaxOS on 13.07.2023.
//

import SwiftUI

struct RandomPhotoView: View {
    
    @StateObject var viewModel: RandomPhotoViewModel
    
    @State private var isShowGalery = false
    @State private var isShowCamera = false
    @State private var isShowAlertNoAddPhoto = false
//    @State var inputImage = UIImage()
//    @State var randomImage = [UIImage]()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        VStack {
            Button("Вернуться в меню") {
                self.dismiss()
            }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                .frame(width: UIScreen.main.bounds.width , alignment: .leading)
            VStack{
                Image(uiImage: viewModel.randomPhotos.showImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(30)
            }.frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width - 50)
            ScrollView(.horizontal){
                LazyHStack() {
                    Text("Загруженные\nизображения:")
                    if !viewModel.randomPhotos.randomImage.isEmpty {
                        ForEach(0..<viewModel.randomPhotos.randomImage.count, id: \.description) { item in
                            ImageCellView(image: $viewModel.randomPhotos.randomImage[item])
                        }
                    }
                }
                
                .frame(height: 100)
                
            }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
            VStack {
                Button("Рандомное изображение") {
                    if viewModel.randomPhotos.randomImage.isEmpty {
                        isShowAlertNoAddPhoto.toggle()
                    } else {
                        viewModel.spinPhoto()
                    }
                }.alert("Вы не выбрали ни одного фото", isPresented: $isShowAlertNoAddPhoto, actions: {
                    Button("Ok, sorry:(") { }
                })
                .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                    .background(Capsule().stroke(.black, lineWidth: 2))
                    .foregroundColor(.black)
                VStack {
                    Button("Изображение из галереи") {
                        isShowGalery.toggle()
                    }
                    .sheet(isPresented: $isShowGalery) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.randomPhotos.inputImage)
                    }
                    .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                    .foregroundColor(.black)
                    .background(Capsule().stroke(.black, lineWidth: 2))
                    
                    Button("Сделать фото") {
                        isShowCamera.toggle()
                    }
                    .sheet(isPresented: $isShowCamera) {
                        ImagePicker(sourceType: .camera, selectedImage: self.$viewModel.randomPhotos.inputImage)
                    }
                    .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                    .background(Capsule().stroke(.black, lineWidth: 2))
                    .foregroundColor(.black)

                }
                .onChange(of: viewModel.randomPhotos.inputImage) { newValue in
                    viewModel.randomPhotos.randomImage.append(newValue)
                }
                
            }
        }
    }
    
}


struct RandomPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RandomPhotoView(viewModel: RandomPhotoViewModel(randomPhotos: RandomPhotoModel(), inputImage: UIImage()))
    }
}
