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
    @State var color = Color(red: Double.random(in: 0.5...1), green: Double.random(in: 0.5...1), blue: Double.random(in: 0.5...1))
    @State var colorRandomNums = Color(red: Double.random(in: 0.5...1), green: Double.random(in: 0.5...1), blue: Double.random(in: 0.5...1))
    @State var colorRandomPhoto = Color(red: Double.random(in: 0.5...1), green: Double.random(in: 0.5...1), blue: Double.random(in: 0.5...1))
    var body: some View {
            VStack {
                VStack {
                    Text("Добро пожаловать в")
                        .font(.custom("Hex", size: 15))
                    Text("Randomizzer")
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .foregroundColor(color)
                }
                .padding()
                Button("Рандомные числа") {
                    isShowRandomNums.toggle()
                }.foregroundColor(colorRandomNums)
                .fullScreenCover(isPresented: $isShowRandomNums) {
                    ContentView(viewModel: RandomNumViewModel(randomNums: RandomNumsModel(), num: 0, number: "3", angle: 0.0))
                }
                .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 30, textFont: .title))
                
                .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                .background(Capsule().stroke(colorRandomNums, lineWidth: 2))
                
                Button("Выбрать рандомные фото") {
                    isShowRandomPhoto.toggle()
                }.foregroundColor(colorRandomPhoto)
                .fullScreenCover(isPresented: $isShowRandomPhoto) {
                    RandomPhotoView()
                }
                .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 30, textFont: .title))
                
                .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                .background(Capsule().stroke(colorRandomNums, lineWidth: 2))
                
            }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
