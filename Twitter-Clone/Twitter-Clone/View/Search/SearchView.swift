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
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
            
            ScrollView {
                
                if (!isEditing || text == "") {
                    LazyVStack {
                        ForEach(0..<20) { i in
                            SearchCell(tag: "Hello", tweets: String(i))
                                .padding(.leading)
                        }
                    }
                }else {
                    LazyVStack {
                        ForEach(self.viewModel.users) { user in
                            searchUserCell(user: user)
                                .padding(.leading)
                        }
                    }
                }
                
//                Spacer()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
