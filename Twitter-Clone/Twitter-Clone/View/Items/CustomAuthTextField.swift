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
    
    @Binding var locked: Bool
    
    init(placeholder: String, text: Binding<String>, locked: Binding<Bool> = .constant(false)) {
        self.placeholder = placeholder
        _text = text
        _locked = locked
    }
    
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
                    .disabled(locked)
                
            }
            
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(.gray)
                .padding(.top, -2)
            
        }
        .padding(.horizontal)
    }
}
