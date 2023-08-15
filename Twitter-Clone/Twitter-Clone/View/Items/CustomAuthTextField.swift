//
//  CustomAuthTextField.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 15/8/23.
//

import SwiftUI

struct CustomAuthTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .frame(height: UITextField().sizeThatFits(UITextField().frame.size).height)
                }
                
                TextField("", text: $text)
                    .frame(height: 45)
                    .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                
            }
            
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(.gray)
                .padding(.top, -2)
            
        }
        .padding(.horizontal)
    }
}