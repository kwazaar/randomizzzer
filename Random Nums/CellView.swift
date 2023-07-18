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
        }.frame(width: 100, height: 100, alignment: .center)
        .background(Color(.white))
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(number: "3")
    }
}
