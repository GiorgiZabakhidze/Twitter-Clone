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
    
    @StateObject var viewModel = SearchViewModel()
    
    var users: [User] {
        return text.isEmpty ? viewModel.users : viewModel.filteredUsers(text)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
                .padding(.top)
            
            RefreshableScrollView(content:
                LazyVStack(alignment: .leading) {
                    ForEach(users) { user in
                        NavigationLink {
                            UserProfile(user: user)
                        } label: {
                            searchUserCell(user: user)
                                .padding(.leading)
                        }
                    }
            }.ignoresSafeArea(.keyboard)) { control in
                control.endRefreshing()
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
