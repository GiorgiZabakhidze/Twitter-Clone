//
//  MainView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

struct MainView: View {
    @State var width = UIScreen.main.bounds.width - 90
    
    @State var x = -UIScreen.main.bounds.width + 90
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    VStack {
                        TopBar(x: $x)
                        Home()
                    }
                    SlideMenu()
                        .shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                        .offset(x: x)
                        .background(Color.black.opacity(x != -width ? 0.5 : 0))
                        .ignoresSafeArea(.all, edges: .vertical)
                        .onTapGesture {
                            withAnimation {
                                x = -width
                            }
                        }
                }
                .gesture(DragGesture().onChanged({ val in
                    withAnimation {
                        if (val.translation.width > 0) {
                            if(x < 0) {
                                x = -width + val.translation.width
                            }
                        }else {
                            if (x != -width) {
                                x = val.translation.width
                            }
                        }
                    }
                }).onEnded({ val in
                    withAnimation {
                        if (val.translation.width > 0) {
                            if (-x < 2 * width/3) {
                                x = 0
                            }else {
                                x = -width
                            }
                        }else {
                            if (-x > width/3) {
                                x = -width
                            }else {
                                x = 0
                            }
                        }
                    }
                }))
            }
            .navigationBarHidden(true)
            .navigationTitle("")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
