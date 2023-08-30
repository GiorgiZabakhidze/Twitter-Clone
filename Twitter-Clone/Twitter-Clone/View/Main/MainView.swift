//
//  MainView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

struct MainView: View {
    
    let user: User
    
    @State var width1 = UIScreen.main.bounds.width - 90
    
    @State var x1 = -UIScreen.main.bounds.width + 90
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    TopBar(x1: $x1)
                    Home(x1: $x1, user: user)
                    SlideMenu(viewModel: AuthViewModel.shared)
                        .shadow(color: Color.black.opacity(x1 != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                        .offset(x: x1)
                        .background(Color.black.opacity(x1 != -width1 ? 0.5 : 0))
                        .ignoresSafeArea(.all, edges: .vertical)
                        .onTapGesture {
                            withAnimation {
                                x1 = -width1
                            }
                        }
                        .gesture(DragGesture().onChanged({ val in
                            withAnimation {
                                if (val.translation.width < 0) {
                                    if (x1 > -width1) {
                                        x1 = val.translation.width
                                    }else {
                                        x1 = -width1
                                    }
                                }else {
                                    
                                }
                            }
                        }).onEnded({ val in
                            withAnimation {
                                if (val.translation.width > 0) {
                                    if (-x1 < 2 * width1/3) {
                                        x1 = 0
                                    }else {
                                        x1 = -width1
                                    }
                                }else {
                                    if (-x1 > width1/3) {
                                        x1 = -width1
                                    }else {
                                        x1 = 0
                                    }
                                }
                            }
                        }))
                        .zIndex(3)
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("")
        }
    }
}
