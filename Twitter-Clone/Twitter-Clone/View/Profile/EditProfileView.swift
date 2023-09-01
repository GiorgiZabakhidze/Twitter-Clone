//
//  EditProfileView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 30/8/23.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presMode
    
    @State var profileImage: Image?
    @State private var selectedImage: UIImage?
    
    @State var imagePickerPresented: Bool = false
    
    @Binding var user: User
    
    @State var name: String
    @State var location: String
    @State var bio: String
    @State var website: String
    
    init(user: Binding<User>) {
        self._user = user
        self._name = State(initialValue: self._user.name.wrappedValue ?? "")
        self._location = State(initialValue: self._user.location.wrappedValue ?? "")
        self._bio = State(initialValue: self._user.bio.wrappedValue ?? "")
        self._website = State(initialValue: self._user.website.wrappedValue ?? "")
    }
    
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        self.presMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(.black)
                    }

                }.padding()
                
                HStack {
                    Spacer()
                    
                    Text("Edit Profile")
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
            }
            
            VStack {
                Image("banner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 180, alignment: .center)
                    .cornerRadius(0)
                    
                HStack {
                    if profileImage == nil {
                        Button {
                            self.imagePickerPresented.toggle()
                        } label: {
                            KFImage(URL(string: "http://localhost:3000/users/id/avatar"))
                                .resizable()
                                .placeholder {
                                    Image("Profile")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                }
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(y: -20)
                                .padding(.leading, 12)
                        }
                        .sheet(isPresented: $imagePickerPresented) {
                            loadImage()
                        } content: {
                            ImagePicker(image: $selectedImage)
                        }


                    }else if let image = profileImage {
//                        VStack {
//                            HStack(alignment: .top) {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    .padding(8)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .offset(y: -20)
                                    .padding(.leading, 12)
//                            }.padding()
//                        }.padding(.leading, 12)
                    }
                    
                    Spacer()
                }
                .onAppear {
                    KingfisherManager.shared.cache.clearCache()
                }
                .padding(.top, -25)
                .padding(.bottom, -10)
                
                VStack {
                    Divider()
                        .padding(.horizontal, 8)
                    
                    HStack {
                        ZStack {
                            HStack {
                                Text("Name")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            
                            CustomProfileTextField(message: $name, placeholder: "Add Your Name")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal, 8)
                    
                    HStack {
                        ZStack {
                            HStack {
                                Text("Location")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            
                            CustomProfileTextField(message: $location, placeholder: "Add Your Location")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal, 8)
                    
                    HStack {
                        ZStack(alignment: .topLeading) {
                            HStack {
                                Text("Bio")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            
                            CustomProfileBioTextField(bio: $bio)
                                .padding(.leading, 86)
                                .padding(.top, -6)
                        }
                    }.padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal, 8)
                    
                    HStack {
                        ZStack {
                            HStack {
                                Text("Website")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            
                            CustomProfileTextField(message: $website, placeholder: "Add Your Website")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                }
                
            }
            
            Spacer()
            
        }
        
    }
}

extension EditProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        
        profileImage = Image(uiImage: selectedImage)
    }
}
