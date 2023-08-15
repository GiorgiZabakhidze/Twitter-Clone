//
//  Home.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct Home: View {
    @State var selectedIndex = 0
    @State var showCreateTweet = false
    @State var text = ""
    
    @State var x = -UIScreen.main.bounds.width
    @Binding var x1: CGFloat
    
    @State var width = UIScreen.main.bounds.width
    @State var width1 = UIScreen.main.bounds.width - 90
    @State var beenThere: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
//                TabView {
                    Feed()
                        .onTapGesture {
                            self.selectedIndex = 0
                        }
                        .navigationBarHidden(true)
                        .tabItem({
                            if (selectedIndex == 0) {
                                Image("house")
                                    
                                    .renderingMode(.template)
                                    .foregroundColor(Color("bg"))
                            }else {
                                Image("house")
                            }
                        })
                        .offset(x: x + width)
                        .tag(0)
                        .gesture(DragGesture().onChanged({ val in
                            withAnimation {
                                if (val.translation.width < 0 && !beenThere) {
                                    if (x1 > -width1) {
                                        x1 = val.translation.width
                                    }else {
                                        x = -width + val.translation.width
                                    }
                                }else {
                                    self.beenThere = true
                                    if (val.translation.width > 0) {
                                        if(x1 < 0) {
                                            x1 = -width1 + val.translation.width
                                        }
                                    }else {
                                        if (x1 > -width1 + 0.1) {
                                            if(abs(abs(x1) - abs(val.translation.width)) < UIScreen.main.bounds.width - 150) {
                                                x1 = val.translation.width
                                            }else {
                                                x1 = -width1
                                            }
                                        }else {
                                            x1 = -width1
                                        }
                                    }
                                }
                            }
                        }).onEnded({ val in
                            withAnimation {
                                self.beenThere = false
                                if(val.translation.width < 0) {
                                    if(val.translation.width < -width/3) {
                                        x = -2 * width
                                    }else {
                                        x = -width
                                    }
                                }else {
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
                            }
                        }))
                        .zIndex(0)
                    SearchView()
                        .onTapGesture {
                            self.selectedIndex = 1
                        }
                        .navigationBarHidden(true)
                        .tabItem({
                            if (selectedIndex != 1) {
                                Image("search")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("bg"))
                            }else {
                                Image("search")
                            }
                        })
                        .offset(x: x + 2 * width)
                        .tag(1)
                        .gesture(DragGesture().onChanged({ val in
                            withAnimation {
                                if (val.translation.width < 0) {
                                    x = -2 * width + val.translation.width
                                }else {
                                    x = -2 * width + val.translation.width
                                }
                            }
                        }).onEnded({ val in
                            withAnimation {
                                if(val.translation.width < 0) {
                                    if(val.translation.width < -width/3) {
                                        x = -3 * width
                                    }else {
                                        x = -2 * width
                                    }
                                }else {
                                    if (val.translation.width > width/3) {
                                        x = -width
                                    }else {
                                        x = -2 * width
                                    }
                                }
                            }
                        }))
                        .zIndex(0)
                    NotificationsView()
                        .onTapGesture {
                            self.selectedIndex = 2
                        }
                        .navigationBarHidden(true)
                        .tabItem({
                            if (selectedIndex != 2) {
                                Image("notification")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("bg"))
                            }else {
                                Image("notification")
                            }
                        })
                        .offset(x: x + 3 *  width)
                        .tag(2)
                        .gesture(DragGesture().onChanged({ val in
                            withAnimation {
                                if (val.translation.width < 0) {
                                    x = -3 * width + val.translation.width
                                }else {
                                    x = -3 * width + val.translation.width
                                }
                            }
                        }).onEnded({ val in
                            withAnimation {
                                if(val.translation.width < 0) {
                                    if(val.translation.width < -width/3) {
                                        x = -4 * width
                                    }else {
                                        x = -3 * width
                                    }
                                }else {
                                    if (val.translation.width > width/3) {
                                        x = -2 * width
                                    }else {
                                        x = -3 * width
                                    }
                                }
                            }
                        }))
                        .zIndex(0)
                    MessagesView()
                        .onTapGesture {
                            self.selectedIndex = 3
                        }
                        .navigationBarHidden(true)
                        .tabItem({
                            if (selectedIndex != 3) {
                                Image("message")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("bg"))
                            }else {
                                Image("message")
                            }
                        })
                        .offset(x: x + 4 * width)
                        .tag(3)
                        .gesture(DragGesture().onChanged({ val in
                            withAnimation {
                                if (val.translation.width < 0) {
                                    x = -4 * width + val.translation.width / 4
                                }else {
                                    x = -4 * width + val.translation.width
                                }
                            }
                        }).onEnded({ val in
                            withAnimation {
                                if(val.translation.width < 0) {
                                    x = -4 * width
                                }else {
                                    if (val.translation.width > width/3) {
                                        x = -3 * width
                                    }else {
                                        x = -4 * width
                                    }
                                }
                            }
                        }))
                        .zIndex(0)
                //}
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            self.showCreateTweet.toggle()
                        } label: {
                            Image("twitter-newtweet")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(Color("bg"))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }.padding()
                }.padding(.bottom, 65)
            }
            .sheet(isPresented: $showCreateTweet) {
                CreateTweetView(text: text)
            }
        }.padding(.top, 60)
    }
}

