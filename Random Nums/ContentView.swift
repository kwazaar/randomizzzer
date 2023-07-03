//
//  ContentView.swift
//  Random Nums
//
//  Created by MaxOS on 03.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var number = "0"
    @State var size = 50
    
    @State var min = 10
    @State var max = 150
    @State var sizeMin = 50
    @State var sizeMax = 150
    
    @State var textFieldMin = ""
    @State var textFieldMax = ""

    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                Text(number)
                    .font(.custom("Hex", size: CGFloat(size)))
            }
            .frame(width: 300, height: 300, alignment: .center)
            VStack {
                Button {
                    size = Int.random(in: sizeMin...sizeMax)
                    number = String(Int.random(in: min...max))
                    
                } label: {
                    Text("Click to get the number")
                }   .foregroundColor(.black)
                    .font(.title)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Capsule().stroke(.black, lineWidth: 4))
                    .cornerRadius(30)
                
                VStack {
                    HStack(spacing: 50){
                        
                        TextField("Minimum value", text: $textFieldMin)
                            
                        TextField("Maximum value", text: $textFieldMax)
                            
                    }
                    .padding(.horizontal, 50.0)
                    Button {
                        min = Int(textFieldMin) ?? 10
                        max = Int(textFieldMax) ?? 150
                        if max >= 9999 {
                            sizeMax = sizeMax / 2
                        } else {
                            sizeMax = 150
                        }
                    } label: {
                        Text("Set boundaries")
                            .foregroundColor(.red)
                            .font(.title)
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .background(Capsule().stroke(.red, lineWidth: 3))
                    }.padding()
                }
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
