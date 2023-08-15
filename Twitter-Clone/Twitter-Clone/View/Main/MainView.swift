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
                }
                .gesture(DragGesture().onChanged({ val in
                    withAnimation {
                        if (val.translation.width > 0) {
                            if(x < 0) {
                                x = -width + val.translation.width
                            }
                        }else {
                            if (x > -width + 0.1) {
                                if(abs(abs(x) - abs(val.translation.width)) < UIScreen.main.bounds.width - 150) {
                                    x = val.translation.width
                                }else {
                                    x = -width
                                }
                            }else {
                                x = -width
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
