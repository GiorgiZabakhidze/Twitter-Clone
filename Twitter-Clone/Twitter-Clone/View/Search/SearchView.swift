//
//  SearchView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
            
            if (!isEditing) {
                List(0..<9) { i in
                    SearchCell(tag: "Heloua", tweets: String(i))
                }.listStyle(PlainListStyle())
            }else {
                List(0..<5) { _ in
                    searchUserCell()
                }.listStyle(PlainListStyle())
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
