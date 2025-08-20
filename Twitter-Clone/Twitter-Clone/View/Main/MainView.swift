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
        ZStack(alignment: .topLeading) {
            VStack{
                TopBar(x1: $x1)
                    .zIndex(4)
                //                .scrollDismissesKeyboard(ScrollDismissesKeyboardMode.immediately)
                Spacer()
            }
            .ignoresSafeArea(.keyboard)
            
            Home(slideManuOffset: $x1, user: user)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            
            SlideMenu(viewModel: AuthViewModel.shared, user: user, x1: $x1)
                .shadow(color: Color.black.opacity(x1 != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: x1)
                .background(Color.black.opacity(x1 != -width1 ? 0.5 : 0))
                .ignoresSafeArea(.keyboard, edges: .vertical)
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
                            if (-x1 > width1/5) {
                                x1 = -width1
                            }else {
                                x1 = 0
                            }
                        }
                    }
                }))
                .zIndex(3)
            
        }
        .ignoresSafeArea(.keyboard)
    }
}
