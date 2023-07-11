//
//  ListView.swift
//  Random Nums
//
//  Created by MaxOS on 10.07.2023.
//
//
import SwiftUI



struct CellView: View {
    
    let number : String
    var body: some View {
        VStack {
                Text(number)
                .font(.custom("Hex", size: 30))
        }.frame(width: 120, height: 50, alignment: .center)
        .background(Color(.white))
        .cornerRadius(10)
    }
    
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(number: "")
    }
}
