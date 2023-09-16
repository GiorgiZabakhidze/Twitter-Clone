//
//  CustomTabView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 15/8/23.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedIndex: Int
    @Binding var x: CGFloat
    @State var width = UIScreen.main.bounds.width
    
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        HStack(spacing: 60) {
            Button {
                selectedIndex = 0
                withAnimation {
                    x = -width
                }
            } label: {
                if (selectedIndex == 0) {
                    Image("house")
                        .renderingMode(.template)
                        .foregroundColor(Color("bg"))
                }else {
                    Image("house")
                }
            }
            
            Button {
                selectedIndex = 1
                withAnimation {
                    x = -2 * width
                }
            } label: {
                if (selectedIndex == 1) {
                    Image("search")
                        .renderingMode(.template)
                        .foregroundColor(Color("bg"))
                }else {
                    Image("search")
                }
            }
            
            Button {
                selectedIndex = 2
                withAnimation {
                    x = -3 * width
                }
            } label: {
                if (selectedIndex == 2) {
                    Image("notification")
                        .renderingMode(.template)
                        .foregroundColor(Color("bg"))
                }else {
                    Image("notification")
                }
            }
            
            Button {
                selectedIndex = 3
                withAnimation {
                    x = -4 * width
                }
            } label: {
                if (selectedIndex == 3) {
                    Image("message")
                        .renderingMode(.template)
                        .foregroundColor(Color("bg"))
                }else {
                    Image("message")
                }
            }
        }
    }
}
