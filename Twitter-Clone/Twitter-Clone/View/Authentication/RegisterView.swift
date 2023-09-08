//
//  RegisterView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 15/8/23.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var name = ""
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
                }
                .padding(.horizontal)
                
                Image("twitter")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 20, height: 20)
            }
            
            Text("Create Your Account")
                .font(.title)
                .bold()
                .padding(.top, 35)
            
            VStack(alignment: .leading, spacing: nil) {
                CustomAuthTextField(placeholder: "Name", text: $name)
                CustomAuthTextField(placeholder: "Username", text: $username)
                CustomAuthTextField(placeholder: "Phone Number or Email", text: $email)
                SecureAuthTextField(placeholder: "password", text: $password)
            }
            
            Spacer(minLength: 0)
            
            VStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                HStack {
                    Spacer()
                    
                    Button {
                        self.viewModel.register(name: name, username: username, email: email, password: password)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Capsule()
                            .frame(width: 110, height: 30, alignment: .center)
                            .foregroundColor(Color(red: 29 / 255, green: 161 / 255, blue: 242 / 255))
                            .overlay {
                                Text("Register")
                                    .foregroundColor(.white)
                            }
                    }

                }.padding(.trailing, 24)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
