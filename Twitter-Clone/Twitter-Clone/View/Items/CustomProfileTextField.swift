//
//  CustomProfileTextField.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 31/8/23.
//

import SwiftUI

struct CustomProfileTextField: View {
    
    @Binding var message: String
    var placeholder: String
    
    var body: some View {
        HStack {
            ZStack {
                HStack {
                    if message.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                
                TextField("", text: $message)
                    .foregroundColor(.blue)
            }
        }
    }
}

