//
//  FirstView.swift
//  Random Nums
//
//  Created by MaxOS on 12.07.2023.
//

import SwiftUI

struct FirstView: View {
    @State var isShowRandomNums = false
    @State var isShowRandomPhoto = false
    @State var isShowRandomMapMark = false
    @State var color = Color(red: Double.random(in: 0.8...1), green: Double.random(in: 0...0.5), blue: Double.random(in: 0...0.5))

    var body: some View {
            VStack {
                VStack {
                    Text("Добро пожаловать в")
                        .font(.custom("Hex", size: 15))
                    Text("Randomizzzer")
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .foregroundColor(color)
                }
                .padding()
                Button("Рандомные числа") {
                    isShowRandomNums.toggle()
                }.foregroundColor(color)
                .fullScreenCover(isPresented: $isShowRandomNums) {
                    RandomNumView(viewModel: RandomNumViewModel(randomNums: RandomNumsModel(), num: 0, number: "3", angle: 0.0))
                }
                .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title2))
                .padding(EdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 5))
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.9))
                .cornerRadius(50)
                
                Button("Рандомные фото") {
                    isShowRandomPhoto.toggle()
                }.foregroundColor(color)
                .fullScreenCover(isPresented: $isShowRandomPhoto) {
                    RandomPhotoView(viewModel: RandomPhotoViewModel(randomPhotos: RandomPhotoModel(), anglePhoto: Double()))
                }
                .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title2))
                .padding(EdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 5))
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.9))
                .cornerRadius(50)
                
                Button("Рандомная точка карты") {
                    isShowRandomMapMark.toggle()
                }.foregroundColor(color)
                .fullScreenCover(isPresented: $isShowRandomMapMark, content: {
                    RandomMapView()
                })
                .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title2))
                .padding(EdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 5))
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.9))
                .cornerRadius(50)
                
            }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
