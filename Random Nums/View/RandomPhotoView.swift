//
//  RandomPhotoView.swift
//  Random Nums
//
//  Created by MaxOS on 13.07.2023.
//

import PhotosUI
import SwiftUI

struct RandomPhotoView: View {
    
    @StateObject var viewModel: RandomPhotoViewModel
    @State var selectItem = [PhotosPickerItem]()
    @State var selectImages = [UIImage]()
    @State var data: Data?
    
    @State private var isShowGalery = false
    @State private var isShowCamera = false
    @State private var isShowAlertNoAddPhoto = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        VStack {
                Button("Вернуться в главное меню") {
                    self.dismiss()
                }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            VStack{
                Image(uiImage: viewModel.randomPhotos.showImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(30)
                    .rotationEffect(.degrees(viewModel.anglePhoto))
                    .animation(.easeIn(duration: 0.2), value: viewModel.anglePhoto)
            }.frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width - 50)
                .padding(30)
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
                    PhotosPicker(selection: $selectItem, selectionBehavior: .ordered, matching: .images, preferredItemEncoding: .automatic, label: {
                        Text(viewModel.randomPhotos.randomImage.isEmpty ? "Изображение из галереи" : "Изменить выбор")
                                })
                                .onChange(of: selectItem, perform: { newValue in
                                    viewModel.randomPhotos.randomImage.removeAll()
                                    Task {
                                        for item in selectItem {
                                            if let data = try? await item.loadTransferable(type: Data.self) {
                                                if let uiImage = UIImage(data: data) {
                                                    viewModel.randomPhotos.randomImage.append(uiImage)
                                                }
                                            }
                                        }
                                    }
                                })
                    .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                    .foregroundColor(.black)
                    .background(Capsule().stroke(.black, lineWidth: 2))
                    
                    Button("Сделать фото") {
                        isShowCamera.toggle()
                    }
                    .fullScreenCover(isPresented: $isShowCamera, content: {
                        ImagePicker(sourceType: .camera, selectedImage: self.$viewModel.randomPhotos.inputImage)
                            .edgesIgnoringSafeArea(.all)
                    })
                    .onChange(of: viewModel.randomPhotos.inputImage) { newValue in
                        viewModel.randomPhotos.randomImage.append(newValue)
                    }
                    .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                    .background(Capsule().stroke(.black, lineWidth: 2))
                    .foregroundColor(.black)
                    
                    Button("Рандомное изображение") {
                        if viewModel.randomPhotos.randomImage.isEmpty {
                            isShowAlertNoAddPhoto.toggle()
                        } else {
                            viewModel.spinPhoto()
                            viewModel.rollPhoto()
                        }
                    }.alert("Для начала выберете фото", isPresented: $isShowAlertNoAddPhoto, actions: {
                        Button("Ок") { }
                    })
                    .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                        .background(Capsule().stroke(.green, lineWidth: 2))
                        .foregroundColor(.green)
                }
        }
    }
    
}


struct RandomPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RandomPhotoView(viewModel: RandomPhotoViewModel(randomPhotos: RandomPhotoModel(), anglePhoto: Double()))
    }
}
