//
//  CustomProfileBioTextField.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 31/8/23.
//

import SwiftUI

struct CustomProfileBioTextField: View {
    
    @Binding var bio: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if bio.isEmpty {
                    HStack {
                        Text("Add a Bio to Your Profile")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.top, 8)
                    .padding(.leading, 4)
                    .onTapGesture {
                        self.isFocused = true
                    }
                    .zIndex(1)
                }
                
                TextEditor(text: $bio)
                    .foregroundColor(.blue)
                    .focused($isFocused)
            }
        }
        .frame(height: 90)
    }
}

