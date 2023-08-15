//
//  WelcomeView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 15/8/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer(minLength: 0)
                    
                    Image("twitter")
                        .resizable()
                        .scaledToFill()
                        .padding(.trailing)
                        .frame(width: 20, height: 20)
                    
                    Spacer(minLength: 0)
                }
                
                Spacer(minLength: 0)
                
                Text("See What's Happening In The World Right Now.")
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .frame(width: 0.9 * (UIScreen.main.bounds.width), alignment: .center)
                
                Spacer(minLength: 0)
                
                VStack(alignment: .center, spacing: 10) {
                    Button {
                        print("Sign in with Google")
                    } label: {
                        HStack(spacing: -4) {
                            Image("Google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("Continue with Google")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding()
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 26)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.3)
                                .frame(width: 320, height: 60, alignment: .center)
                             
                                
                        }
                    }
                    
                    Button {
                        print("Sign in with Apple")
                    } label: {
                        HStack(spacing: -4) {
                            Image("Apple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("Continue with Apple")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.black)
                                .padding()
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 26)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.3)
                                .frame(width: 320, height: 60, alignment: .center)
                             
                                
                        }
                    }

                    ZStack(alignment: .center) {
                        Divider()
                            .foregroundColor(.gray )
                            .opacity(1)
                            .padding(.horizontal)
                        Text("Or")
                            .foregroundColor(.gray)
                            .padding(.bottom, 2)
                            .frame(width: 35, height: 20)
                            .background(.white)
                    }
                    
                    RoundedRectangle(cornerRadius: 36)
                        .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                        .frame(width: 320, height: 60, alignment: .center)
                        .overlay(
                            Text("Create Account")
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                        )
                    
                }.padding()
                
                VStack(alignment: .leading) {
                    VStack {
                        Text("By signing in, you agree to our ")
                        +
                        Text("Terms")
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                        +
                        Text(", ")
                        +
                        Text("Privacy Policy")
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                        +
                        Text(", ")
                        +
                        Text("Cookie Use")
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                        +
                        Text(".")
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 2) {
                        Text("Have an Account Already? ")
                        Text("Log In")
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                    }
                }
                
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
