//
//  SearchBar.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            TextField("Search Twitter..", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay (
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .focused($isFocused)
                .onChange(of: isFocused) { focused in
                    withAnimation {
                        isEditing = focused
                    }
                }
            
            if(isEditing) {
                Button {
                    text = ""
                    isFocused = false;
                    withAnimation {
                        isEditing = false
                    }
                } label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                        .padding(.trailing, 8)
                        .transition(.move(edge: .trailing))
                        
                }
            }
        }
        .padding(.top, 4)
    }
}
