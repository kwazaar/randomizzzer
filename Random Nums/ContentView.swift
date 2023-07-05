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
    

    var body: some View {
        VStack(alignment: .center) {
            
            
                VStack {
                    if isShowNum {
                        Text(viewModel.randomNums.randomNum)
                            .font(.custom("Hex", size: CGFloat(viewModel.randomNums.randomSize)))
                        
                    }
                }
                .frame(width: 300, height: 300, alignment: .center)
            
            
            VStack {
                
                
                VStack {
                    HStack(spacing: 50){
                        VStack(alignment: .leading){
                            Text("От: \(viewModel.randomNums.minNums)")
                            
                            TextField("Минимум", text: $textFieldMin)
                                .keyboardType(.numberPad)
                                .focused($keyIsFocused)
                        }
                        VStack(alignment: .leading) {
                            Text("До: \(viewModel.randomNums.maxNums)")
                            TextField("Максимум", text: $textFieldMax)
                                .keyboardType(.numberPad)
                                .focused($keyIsFocused)
                        }
                            
                    }
                    .padding(.horizontal, 50.0)
                    
                    Button {
                            viewModel.randomNums.minNums = Int(textFieldMin) ?? 1
                            viewModel.randomNums.maxNums = Int(textFieldMax) ?? 100
                        
                        if viewModel.randomNums.minNums >= viewModel.randomNums.maxNums {
                            viewModel.randomNums.minNums = 1
                            viewModel.randomNums.maxNums = 100
                            isShowAlert.toggle()
                            
                        }
//                        }
                        textFieldMax = ""
                        textFieldMin = ""
                        keyIsFocused = false
                        
                        if viewModel.randomNums.maxNums >= 9999 {
                            viewModel.randomNums.sizeFontMax = viewModel.randomNums.sizeFontMax / 2
                        } else {
                            viewModel.randomNums.sizeFontMax = 150
                        }
                    } label: {
                        if textFieldMin.isEmpty && textFieldMax.isEmpty {
                            Text("Значения по умолчанию")
                                .frame(width: 300)
                                .foregroundColor(.red)
                                .font(.title2)
                                .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                                .background(Capsule().stroke(.red, lineWidth: 2))
                                
                        } else {
                            Text("Установить значение")
                                .frame(width: 300)
                                .foregroundColor(.green)
                                .font(.title)
                                .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                                .background(Capsule().stroke(.green, lineWidth: 2))
                            
                        }
                    }.alert("Вы ввели неверные значения минимума и максимума! \nПопробуйте снова.", isPresented: $isShowAlert, actions: {
                        Button("Oк") { }
                    })
                    .padding()

                    Button {
                        isShowNum = true
                        keyIsFocused = false
                        viewModel.spinRundomSize()
                        
                    } label: {
                        Text("Получить число")
                    }   .foregroundColor(.black)
                        .frame(width: 300)
                        .font(.title)
                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                        .background(Capsule().stroke(.black, lineWidth: 4))
                        .cornerRadius(30)
                    
                    
                    
                }
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: RandomNumViewModel(randomNums: RandomNumsModel()))
    }
}
