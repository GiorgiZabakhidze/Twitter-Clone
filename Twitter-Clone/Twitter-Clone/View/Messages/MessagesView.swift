//
//  MessagesView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var viewModel = MessagesViewModel()
    
    var body: some View {
        VStack {
            RefreshableScrollView(content:
                ForEach(viewModel.messages) { message in
                    MessagesCellView(message: message)
            }) { control in
                control.endRefreshing()
            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
