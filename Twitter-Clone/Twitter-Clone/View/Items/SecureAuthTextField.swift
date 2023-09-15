//
//  CustomAuthTextField.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 15/8/23.
//

import SwiftUI

struct SecureAuthTextField: View {
    var placeholder: String
    @Binding var text: String
    
    @State var isHidden: Bool = true
    
    @FocusState var focused: Field?
    
    enum Field {
        case secure, plain
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                    }
                    
                    if (isHidden) {
                        SecureField("", text: $text)
                            .focused($focused, equals: .secure)
                            .frame(height: 45)
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                    }else {
                        TextField("", text: $text)
                            .focused($focused, equals: .plain)
                            .frame(height: 45)
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                    }
                    
                }
                
                if (!text.isEmpty) {
                    Button {
                        self.isHidden.toggle()
                        focused = isHidden ? .secure : .plain
                    } label: {
                        Image(systemName: isHidden ? "eye" : "eye.slash")
                            .resizable()
                            .frame(width: 18, height: 15)
                            .foregroundColor(isHidden ? Color("bg") : .red)
                    }
                    .padding(.trailing, 2)
                }

            }
            
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(.gray)
                .padding(.top, -2 + (!text.isEmpty ? (UITextView().sizeThatFits(UITextView().frame.size).height - UITextField().sizeThatFits(UITextField().frame.size).height) / 2 + 0.2 : 0))
            
        }.padding(.horizontal)
    }
}
