//
//  ContentView.swift
//  Random Nums
//
//  Created by MaxOS on 03.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: RandomNumViewModel
    @State var textFieldMin = ""
    @State var textFieldMax = ""
    @State private var isShowAlert = false
    @State private var isShowNum = false
    @FocusState private var keyIsFocused: Bool
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        
            
            VStack(alignment: .center) {
                VStack(){
                    Button("Вернуться в меню") {
                        self.dismiss()
                    }
                    .frame(height: 1)
                    .padding()
                }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                    .frame(width: UIScreen.main.bounds.width , alignment: .leading)
                
                
                VStack {
                    
                        if isShowNum {
                            Text("\(viewModel.num)")
                                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.6))
                                .rotationEffect(.degrees(viewModel.angle))
                                .animation(.easeIn(duration: 0.2), value: viewModel.angle)
                                .font(.custom("Hex", size: CGFloat(viewModel.randomNums.randomSize)))
                            
                        }
                }
                .frame(width: 300, height: 300, alignment: .center)
                Spacer()
                VStack {
                    VStack {
                        ScrollView(.horizontal){
                            LazyHStack {
                                Text("Полученные числа: ")
                                ForEach(0..<viewModel.arrayNums.count, id: \.description) { item in
                                    CellView(number: String(self.viewModel.arrayNums[item]))
                                }
                            }
                        }
                        .modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                        .frame(width: UIScreen.main.bounds.width , height: 100)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Минимум: \(viewModel.randomNums.minNums)")
                                
                                TextField("Введите значение", text: $textFieldMin)
                                    .keyboardType(.numberPad)
                                    .focused($keyIsFocused)
                            }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                            
                            VStack(alignment: .trailing) {
                                Text("Максимум: \(viewModel.randomNums.maxNums)")
                                    .multilineTextAlignment(.trailing)
                                TextField("Введите значение", text: $textFieldMax)
                                    .keyboardType(.numberPad)
                                    .focused($keyIsFocused)
                                    .multilineTextAlignment(.trailing)
                            }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: .white, endColor:  Color(hue: 1.0, saturation: 0.0, brightness: 0.9), textColor: Color.gray))
                            
                        }
                        Button {
                            viewModel.randomNums.minNums = Int(textFieldMin) ?? 1
                            viewModel.randomNums.maxNums = Int(textFieldMax) ?? 100
                            
                            if viewModel.randomNums.minNums >= viewModel.randomNums.maxNums {
                                viewModel.randomNums.minNums = 1
                                viewModel.randomNums.maxNums = 100
                                isShowAlert.toggle()
                            }
                            
                            textFieldMax = ""
                            textFieldMin = ""
                            keyIsFocused = false
                            
                            viewModel.chekSizeNums()
                        } label: {
                            if textFieldMin.isEmpty && textFieldMax.isEmpty {
                                Text("Значения по умолчанию")
                                    .foregroundColor(.red)
                                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                                    .background(Capsule().stroke(.red, lineWidth: 2))
                            } else  {
                                Text("Установить значение")
                                    .foregroundColor(.green)
                                    .padding(EdgeInsets(top: 8, leading: 30, bottom: 8, trailing: 30))
                                    .background(Capsule().stroke(.green, lineWidth: 2))
                                
                            }
                        }
                            
                            .modifier(customButtonViewModifer(widthFrame: 350, textFont: .title))
                            .alert("Вы ввели неверные значения минимума и максимума! \nПопробуйте снова.", isPresented: $isShowAlert, actions: {
                                Button("Oк") { }
                            })
                            .padding()
                        }

                        
                        Button {
                            viewModel.rollNum()
                            isShowNum = true
                            keyIsFocused = false
                            viewModel.spinRundomSize()
                            viewModel.addNumHistroy()
                            
                        } label: {
                            Text("Получить число")
                        }.modifier(customButtonViewModifer(widthFrame: 300, textFont: .title))
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                            .background(Capsule().stroke(.black, lineWidth: 4))
                            .cornerRadius(30)
                        
                        
                        
                    }
                }
            }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: RandomNumViewModel(randomNums: RandomNumsModel(), num: 3, number: "3", angle: 0.0))
    }
}
