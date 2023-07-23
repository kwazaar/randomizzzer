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
                .padding(20)

        }
        .background(Color(.white))
        .cornerRadius(20)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(number: "3")
    }
}
