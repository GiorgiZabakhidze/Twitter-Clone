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
    
    @State var userChanged: Bool = true
    
    @State var incorrectPassword: String = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        withAnimation {
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
                
                    Text(!emailDone ? "To Get Started, First Enter Your Phone, Email or @username" : "Enter your Password")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    if (!emailDone) {
                        CustomAuthTextField(placeholder: "Phone, Email or @username", text: $email)
                    }else {
                        SecureAuthTextField(placeholder: "Password", text: $password)
                    }
                    
                    if (!userChanged) {
                        
                        if (incorrectPassword == password) {
                            Text("Incorrect Email or Password")
                                .foregroundColor(.red)
                                .padding(.top, 20)
                        }
                        
                    }
                }
                
                Spacer(minLength: 0)
                
                VStack {
                    Button {
                        if (!emailDone) {
                            if email.contains("@") {
                                self.emailDone = true
                            }
                        }else {
                            self.emailDone = true
                            self.email = self.email.lowercased()
                            let previousUserId = UserDefaults.standard.string(forKey: "userid")
                            print("previousUserId: \(previousUserId)")
                            self.viewModel.login(email: email, password: password) {
                                
                                if (self.viewModel.isNewIdSet) {
                                    self.presentationMode.wrappedValue.dismiss()
                                    self.userChanged = true
                                }else {
                                    self.userChanged = false
                                }
                                
                                print("newUserId: \(UserDefaults.standard.value(forKey: "userid"))")
                                if (!userChanged) {
                                    self.incorrectPassword = password
                                }
                            }
                        }
                        
                        
                    } label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                            .overlay {
                                Text(!emailDone ? "Next" : "Log in")
                                    .foregroundColor(.white)
                            }
                    }
                    .padding(.bottom, 4)
                    
                    if (emailDone) {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                    }

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
