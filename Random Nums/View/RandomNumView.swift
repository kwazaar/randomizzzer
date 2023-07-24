//
//  ContentView.swift
//  Random Nums
//
//  Created by MaxOS on 03.07.2023.
//

import SwiftUI

struct RandomNumView: View {
    
    @StateObject var viewModel: RandomNumViewModel
    @State var textFieldMin = ""
    @State var textFieldMax = ""
    @State private var isShowAlert = false
    @State private var isShowNum = false
    @State private var isShowEmptyTextField = false
    @FocusState private var keyIsFocused: Bool
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        
            
            VStack(alignment: .center) {
                VStack(){
                    Button("Вернуться в главное меню") {
                        self.dismiss()
                    }
                }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                    .frame(width: UIScreen.main.bounds.width , alignment: .leading)
                Spacer()
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
                    }

                        Button("Установить значение") {
                            if textFieldMin.isEmpty || textFieldMax.isEmpty {
                                isShowEmptyTextField.toggle()
                            } else {
                                viewModel.randomNums.intTextFieldMin = Int(textFieldMin)!
                                viewModel.randomNums.intTextFieldMax = Int(textFieldMax)!
                                if viewModel.randomNums.intTextFieldMin >= viewModel.randomNums.intTextFieldMax {
                                    isShowAlert.toggle()
                                } else {
                                    viewModel.randomNums.minNums = Int(textFieldMin)!
                                    viewModel.randomNums.maxNums = Int(textFieldMax)!
                                }
                            }
                            textFieldMax = ""
                            textFieldMin = ""
                            keyIsFocused = false
                            viewModel.chekSizeNums()
                        }
                        .alert("Поле ввода значений пустое",isPresented: $isShowEmptyTextField, actions: {
                            Button("Ввести значения") {}
                            Button("Установить по умолчанию") {
                                viewModel.randomNums.minNums = 1
                                viewModel.randomNums.maxNums = 100
                            }
                        })
                        .alert("Вы ввели неверные значения минимума и максимума! \nПопробуйте снова.", isPresented: $isShowAlert, actions: { Button("Ок") { } })
                        .modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                        .foregroundColor((textFieldMax.isEmpty && textFieldMin.isEmpty) ? .gray : .red)
                        .background(Capsule().stroke((textFieldMax.isEmpty && textFieldMin.isEmpty) ? .gray : .red, lineWidth: 2))
                    
                        Button {
                            viewModel.rollNum()
                            isShowNum = true
                            keyIsFocused = false
                            viewModel.spinRundomSize()
                            viewModel.addNumHistroy()
                            
                        } label: {
                            Text("Получить число")
                        }.modifier(customButtonViewModifer(widthFrame: UIScreen.main.bounds.width - 50, textFont: .title))
                            .foregroundColor(.green)
                            .background(Capsule().stroke(.green, lineWidth: 2))
                        
                        
                        
                    }
                }
            }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RandomNumView(viewModel: RandomNumViewModel(randomNums: RandomNumsModel(), num: 3, number: "3", angle: 0.0))
    }
}
