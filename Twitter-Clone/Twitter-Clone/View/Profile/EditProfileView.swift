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
            
            Image("banner")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 180, alignment: .center)
                .cornerRadius(0)
                
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
                VStack {
                    HStack(alignment: .top) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                            .offset(y: -20)
                    }.padding()
                }.padding(.leading, 12)
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
