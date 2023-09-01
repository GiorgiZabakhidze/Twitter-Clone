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
    
    @State var windowStartingPoint = -UIScreen.main.bounds.width
    @Binding var slideManuOffset: CGFloat
    
    @State var widndowFrameWidth = UIScreen.main.bounds.width
    @State var slideManuWidth = UIScreen.main.bounds.width - 90
    
    @State var beenThere: Bool = false
    static let minDistanceToStartScrolling: CGFloat = 20
    
    let user: User
    
    var body: some View {
        VStack {
            ZStack {
                Feed(user: user)
                    .navigationBarHidden(true)
                    .offset(x: windowStartingPoint + widndowFrameWidth)
                    .tag(0)
                    .gesture(DragGesture().onChanged({ currentFrame in
                        let shouldScroll: Bool = abs(currentFrame.translation.width) > Home.minDistanceToStartScrolling
                        if shouldScroll {
                        
                            withAnimation {
                                let scroledRight: Bool = currentFrame.translation.width < 0
                                
                                if (scroledRight && !beenThere) {
                                    if (slideManuOffset > -slideManuWidth) {
                                        slideManuOffset = currentFrame.translation.width
                                    }else {
                                        windowStartingPoint = -widndowFrameWidth + currentFrame.translation.width
                                    }
                                } else {
                                    self.beenThere = true
                                    if (currentFrame.translation.width >= 0) {
                                        if(slideManuOffset < 0) {
                                            slideManuOffset = -slideManuWidth + currentFrame.translation.width
                                        }
                                    }else {
                                        if (slideManuOffset > -slideManuWidth) {
                                            if(abs(abs(slideManuOffset) - abs(currentFrame.translation.width)) < UIScreen.main.bounds.width - 150) {
                                                slideManuOffset = currentFrame.translation.width
                                            }else {
                                                slideManuOffset = -slideManuWidth
                                            }
                                        }else {
                                            slideManuOffset = -slideManuWidth
                                        }
                                    }
                                }
                            }
                        }
                    })
                    .onEnded({ val in
                        withAnimation {
                            if(val.translation.width < 0 && !beenThere) {
                                if(val.translation.width < -widndowFrameWidth/3) {
                                    windowStartingPoint = -2 * widndowFrameWidth
                                    selectedIndex = 1
                                }else {
                                    windowStartingPoint = -widndowFrameWidth
                                }
                            }else {
                                if (val.translation.width >= 0) {
                                    if (-slideManuOffset < 2 * slideManuWidth/3) {
                                        slideManuOffset = 0
                                    }else {
                                        slideManuOffset = -slideManuWidth
                                    }
                                }else {
                                    if (-slideManuOffset > slideManuWidth/3) {
                                        slideManuOffset = -slideManuWidth
                                    }else {
                                        slideManuOffset = 0
                                    }
                                }
                            }
                            self.beenThere = false
                        }
                    })
                        
                    )
                    .zIndex(0)
                SearchView()
                    .navigationBarHidden(true)
                    .offset(x: windowStartingPoint + 2 * widndowFrameWidth)
                    .tag(1)
                    .gesture(DragGesture().onChanged({ val in
                        UIApplication.shared.endEditing()
                        withAnimation {
                            if (val.translation.width < 0) {
                                windowStartingPoint = -2 * widndowFrameWidth + val.translation.width
                            }else {
                                windowStartingPoint = -2 * widndowFrameWidth + val.translation.width
                            }
                        }
                    }).onEnded({ val in
                        withAnimation {
                            if(val.translation.width < 0) {
                                if(val.translation.width < -widndowFrameWidth/3) {
                                    windowStartingPoint = -3 * widndowFrameWidth
                                    selectedIndex = 2
                                }else {
                                    windowStartingPoint = -2 * widndowFrameWidth
                                }
                            }else {
                                if (val.translation.width > widndowFrameWidth/3) {
                                    windowStartingPoint = -widndowFrameWidth
                                    selectedIndex = 0
                                }else {
                                    windowStartingPoint = -2 * widndowFrameWidth
                                }
                            }
                        }
                    }))
                    .zIndex(0)
                NotificationsView()
                    .navigationBarHidden(true)
                    .offset(x: windowStartingPoint + 3 *  widndowFrameWidth)
                    .tag(2)
                    .gesture(DragGesture().onChanged({ val in
                        withAnimation {
                            if (val.translation.width < 0) {
                                windowStartingPoint = -3 * widndowFrameWidth + val.translation.width
                            }else {
                                windowStartingPoint = -3 * widndowFrameWidth + val.translation.width
                            }
                        }
                    }).onEnded({ val in
                        withAnimation {
                            if(val.translation.width < 0) {
                                if(val.translation.width < -widndowFrameWidth/3) {
                                    windowStartingPoint = -4 * widndowFrameWidth
                                    selectedIndex = 3
                                }else {
                                    windowStartingPoint = -3 * widndowFrameWidth
                                }
                            }else {
                                if (val.translation.width > widndowFrameWidth/3) {
                                    windowStartingPoint = -2 * widndowFrameWidth
                                    selectedIndex = 1
                                }else {
                                    windowStartingPoint = -3 * widndowFrameWidth
                                }
                            }
                        }
                    }))
                    .zIndex(0)
                
                MessagesView()
                    .navigationBarHidden(true)
                    .offset(x: windowStartingPoint + 4 * widndowFrameWidth)
                    .tag(3)
                    .gesture(DragGesture().onChanged({ val in
                        withAnimation {
                            if (val.translation.width < 0) {
                                windowStartingPoint = -4 * widndowFrameWidth + val.translation.width / 20
                            }else {
                                windowStartingPoint = -4 * widndowFrameWidth + val.translation.width
                            }
                        }
                    }).onEnded({ val in
                        withAnimation {
                            if(val.translation.width < 0) {
                                windowStartingPoint = -4 * widndowFrameWidth
                            }else {
                                if (val.translation.width > widndowFrameWidth/3) {
                                    windowStartingPoint = -3 * widndowFrameWidth
                                    selectedIndex = 2
                                }else {
                                    windowStartingPoint = -4 * widndowFrameWidth
                                }
                            }
                        }
                    }))
                    .zIndex(0)
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
                }
                .padding(.bottom, 35)
                .sheet(isPresented: $showCreateTweet) {
                    CreateTweetView(show: $showCreateTweet, text: text)
                }
            }.padding(.top, 60)
            
            CustomTabView(selectedIndex: $selectedIndex, x: $windowStartingPoint)
                
        }
        .ignoresSafeArea(.keyboard)
    }
}

