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
    @State var x1 = -UIScreen.main.bounds.width + 90
    
    @State var width = UIScreen.main.bounds.width
    @State var width1 = UIScreen.main.bounds.width - 90
    
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
                                if (val.translation.width < 0) {
                                    x = -width + val.translation.width
                                }
                            }
                        }).onEnded({ val in
                            withAnimation {
                                if(val.translation.width < 0) {
                                    if(val.translation.width < -width/3) {
                                        x = -2 * width
                                    }else {
                                        x = -width
                                    }
                                }
                            }
                        }))
                    SlideMenu()
                        .shadow(color: Color.black.opacity(x1 != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                        .offset(x: x1)
                        .background(Color.black.opacity(x1 != -width1 ? 0.5 : 0))
                        .ignoresSafeArea(.all, edges: .vertical)
                        .onTapGesture {
                            withAnimation {
                                x1 = -width1
                            }
                        }
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
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
