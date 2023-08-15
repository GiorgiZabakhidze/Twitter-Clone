//
//  LogInView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 15/8/23.
//

import SwiftUI

struct LogInView: View {
    @State var email = ""
    @State var password = ""
    @State var emailDone = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if (!emailDone && !email.contains("@")) {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()

                        }.padding(.horizontal)
                        
                        Image("twitter")
                            .resizable()
                            .scaledToFill()
                            .padding(.trailing)
                            .frame(width: 20, height: 20)
                            
                    }
                
                    Text("To Get Started, First Enter Your Phone, Email or @username")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    CustomAuthTextField(placeholder: "Phone, Email or @username", text: $email)
                }
                
                Spacer(minLength: 0)
                
                VStack {
                    Button {
                        if email.contains("@") {
                            self.emailDone = true
                        }
                    } label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                            .overlay {
                                Text("Next")
                                    .foregroundColor(.white)
                            }
                    }
                    .padding(.bottom, 4)
                    
                    Text("Forgot Password?")
                        .foregroundColor(.blue)

                }
            }
        }else {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()

                        }.padding(.horizontal)
                        
                        Image("twitter")
                            .resizable()
                            .scaledToFill()
                            .padding(.trailing)
                            .frame(width: 20, height: 20)
                            
                    }
                
                    Text("Enter your Password")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    SecureAuthTextField(placeholder: "Password", text: $password)
                }
                
                Spacer(minLength: 0)
                
                VStack {
                    Button {
                        self.emailDone = true
                    } label: {
                        NavigationLink {
                            MainView()
                                .navigationBarHidden(true)
                        } label: {
                            Capsule()
                                .frame(width: 360, height: 40, alignment: .center)
                                .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                                .overlay {
                                    Text("Log in")
                                        .foregroundColor(.white)
                                }
                        }

                    }
                    .padding(.bottom, 4)
                    
                    Text("Forgot Password?")
                        .foregroundColor(.blue)

                }
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
