//
//  ContentView.swift
//  Twitter-Clone
//
//  Created by Giorgi Zabakhidze on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if (viewModel.isAuthenticated) {
            if let user = viewModel.currentUser {
                MainView(user: user)
            }
        }else {
            WelcomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
