//
//  TextFieldViewModifer.swift
//  Random Nums
//
//  Created by MaxOS on 06.07.2023.
//

import SwiftUI

struct customTextFieldViewModifer: ViewModifier {
    
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(roundedCornes)
            .foregroundColor(textColor)
            .font(.custom("Open Sans", size: 18))

    }
}

struct customButtonViewModifer: ViewModifier {
    
    var widthFrame: CGFloat
    var textFont: Font
    
    func body(content: Content) -> some View {
        content
            .frame(width: widthFrame)
            .font(textFont)
    }
    
    
}
