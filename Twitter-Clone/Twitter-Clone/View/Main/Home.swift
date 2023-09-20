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
    @State var showSendMessage = false
    @State var text = ""
    
    @State var windowStartingPoint = -UIScreen.main.bounds.width
    @Binding var slideManuOffset: CGFloat
    
    @State var windowFrameWidth = UIScreen.main.bounds.width
    @State var slideMenuWidth = UIScreen.main.bounds.width - 90
    
    @State var beenThere: Bool = false
    static let minDistanceToStartScrolling: CGFloat = 20
    
    let user: User
    
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Feed(user: user)
                    .navigationBarHidden(true)
                    .offset(x: windowStartingPoint + windowFrameWidth)
                    .tag(0)
                    .gesture(DragGesture().onChanged({ currentFrame in
                        let shouldScroll: Bool = abs(currentFrame.translation.width) > Home.minDistanceToStartScrolling
                        if shouldScroll {
                        
                            withAnimation {
                                let scroledRight: Bool = currentFrame.translation.width < 0
                                
                                if (scroledRight && !beenThere) {
                                    if (slideManuOffset > -slideMenuWidth) {
                                        slideManuOffset = currentFrame.translation.width
                                    }else {
                                        windowStartingPoint = -windowFrameWidth + currentFrame.translation.width
                                    }
                                } else {
                                    self.beenThere = true
                                    if (currentFrame.translation.width >= 0) {
                                        if(slideManuOffset < 0) {
                                            slideManuOffset = -slideMenuWidth + currentFrame.translation.width
                                        }
                                    }else {
                                        if (slideManuOffset > -slideMenuWidth) {
                                            if(abs(abs(slideManuOffset) - abs(currentFrame.translation.width)) < UIScreen.main.bounds.width - 150) {
                                                slideManuOffset = currentFrame.translation.width
                                            }else {
                                                slideManuOffset = -slideMenuWidth
                                            }
                                        }else {
                                            slideManuOffset = -slideMenuWidth
                                        }
                                    }
                                }
                            }
                        }
                    })
                    .onEnded({ val in
                        withAnimation {
                            if(val.translation.width < 0 && !beenThere) {
                                if(val.translation.width < -windowFrameWidth/3) {
                                    windowStartingPoint = -2 * windowFrameWidth
                                    selectedIndex = 1
                                }else {
                                    windowStartingPoint = -windowFrameWidth
                                }
                            }else {
                                if (val.translation.width >= 0) {
                                    if (-slideManuOffset < 2 * slideMenuWidth/3) {
                                        slideManuOffset = 0
                                    }else {
                                        slideManuOffset = -slideMenuWidth
                                    }
                                }else {
                                    if (-slideManuOffset > slideMenuWidth/3) {
                                        slideManuOffset = -slideMenuWidth
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
                    .offset(x: windowStartingPoint + 2 * windowFrameWidth)
                    .tag(1)
                    .gesture(DragGesture().onChanged({ val in
                        UIApplication.shared.endEditing()
                        withAnimation {
                            if (val.translation.width < 0) {
                                windowStartingPoint = -2 * windowFrameWidth + val.translation.width
                            }else {
                                windowStartingPoint = -2 * windowFrameWidth + val.translation.width
                            }
                        }
                    }).onEnded({ val in
                        withAnimation {
                            if(val.translation.width < 0) {
                                if(val.translation.width < -windowFrameWidth/3) {
                                    windowStartingPoint = -3 * windowFrameWidth
                                    selectedIndex = 2
                                }else {
                                    windowStartingPoint = -2 * windowFrameWidth
                                }
                            }else {
                                if (val.translation.width > windowFrameWidth/3) {
                                    windowStartingPoint = -windowFrameWidth
                                    selectedIndex = 0
                                }else {
                                    windowStartingPoint = -2 * windowFrameWidth
                                }
                            }
                        }
                    }))
                    .zIndex(0)
                NotificationsView()
//                    .onAppear {
//                        viewModel.fetchUserNotifications()
//                    }
                    .navigationBarHidden(true)
                    .offset(x: windowStartingPoint + 3 *  windowFrameWidth)
                    .tag(2)
                    .gesture(DragGesture().onChanged({ val in
                        withAnimation {
                            if (val.translation.width < 0) {
                                windowStartingPoint = -3 * windowFrameWidth + val.translation.width
                            }else {
                                windowStartingPoint = -3 * windowFrameWidth + val.translation.width
                            }
                        }
                    }).onEnded({ val in
                        withAnimation {
                            if(val.translation.width < 0) {
                                if(val.translation.width < -windowFrameWidth/3) {
                                    windowStartingPoint = -4 * windowFrameWidth
                                    selectedIndex = 3
                                }else {
                                    windowStartingPoint = -3 * windowFrameWidth
                                }
                            }else {
                                if (val.translation.width > windowFrameWidth/3) {
                                    windowStartingPoint = -2 * windowFrameWidth
                                    selectedIndex = 1
                                }else {
                                    windowStartingPoint = -3 * windowFrameWidth
                                }
                            }
                        }
                    }))
                    .zIndex(0)
                
                MessagesView()
                    .navigationBarHidden(true)
                    .offset(x: windowStartingPoint + 4 * windowFrameWidth)
                    .tag(3)
                    .gesture(DragGesture().onChanged({ val in
                        withAnimation {
                            if (val.translation.width < 0) {
                                windowStartingPoint = -4 * windowFrameWidth + val.translation.width / 20
                            }else {
                                windowStartingPoint = -4 * windowFrameWidth + val.translation.width
                            }
                        }
                    }).onEnded({ val in
                        withAnimation {
                            if(val.translation.width < 0) {
                                windowStartingPoint = -4 * windowFrameWidth
                            }else {
                                if (val.translation.width > windowFrameWidth/3) {
                                    windowStartingPoint = -3 * windowFrameWidth
                                    selectedIndex = 2
                                }else {
                                    windowStartingPoint = -4 * windowFrameWidth
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
                            if (windowStartingPoint > -2*windowFrameWidth) {
                                self.showCreateTweet.toggle()
                            }else {
                                self.showSendMessage.toggle()
                            }
                        } label: {
                            if (windowStartingPoint > -2 * windowFrameWidth) {
                                Image("twitter-newtweet")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding()
                                    .background(Color("bg"))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }else {
                                Image(systemName: "square.and.pencil")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding()
                                    .background(Color("bg"))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                        }
                        .opacity(CreateTweetOpacity())
                    }.padding()
                }
                .zIndex(3)
                .padding(.bottom, 35)
                .sheet(isPresented: $showCreateTweet) {
                    CreateTweetView(show: $showCreateTweet, text: text)
                }
                .sheet(isPresented: $showSendMessage) {
                    CreateNewMessageView(showSendMessageView: $showSendMessage)
                }
            }.padding(.top, 60)
            
            CustomTabView(selectedIndex: $selectedIndex, x: $windowStartingPoint)
                
        }
        .ignoresSafeArea(.keyboard)
    }
}

extension Home {
    func CreateTweetOpacity() -> Double {
        if (windowStartingPoint >= -windowFrameWidth - 20) {
            return 1
        }else if ( windowStartingPoint < -windowFrameWidth - 20 && windowStartingPoint > -1.5 * windowFrameWidth) {
            return (windowStartingPoint + 2*windowFrameWidth) / windowFrameWidth
        }else if (windowStartingPoint < -3.5*windowFrameWidth && windowStartingPoint > -4*windowFrameWidth) {
            return (-windowStartingPoint - 3*windowFrameWidth) / windowFrameWidth
        }else if (windowStartingPoint <= -4*windowFrameWidth) {
            return 1
        }else {
            return 0
        }
    }
}

