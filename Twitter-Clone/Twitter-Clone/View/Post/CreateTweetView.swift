//
//  CretaeTweetView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct CreateTweetView: View {
    
    @ObservedObject var viewModel = CreateTweetViewModel()
    
    @Binding var show: Bool
    @State var text = ""
    @State var imagePickerPresented: Bool = false
    @State var selectedImage: UIImage?
    @State var postImage: Image?
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.show.toggle()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    
                    if !text.isEmpty {
                        self.show.toggle()
                        self.viewModel.uploadPost(text: text, image: selectedImage)
                    }else {
                        print("Cannot Post Empty Tweet")
                    }
            
                } label: {
                    Text("Tweet").padding()
                }
                .background(Color("bg"))
                .foregroundColor(.white)
                .clipShape(Capsule())

            }
            
            MultilineTextField(text: $text)
            
            if postImage == nil {
                Button {
                    self.imagePickerPresented.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                        .padding(.top)
                        .foregroundColor(.black)
                }.sheet(isPresented: $imagePickerPresented) {
                    loadImage()
                } content: {
                    ImagePicker(image: $selectedImage)
                    
                }
            }else if let image = postImage {
                VStack {
                    
                    HStack(alignment: .top) {
                        image
                            .resizable()
                            .scaledToFill()
                            .padding(.horizontal)
                            .frame(width: 0.9 * UIScreen.main.bounds.width)
                            .cornerRadius(16)
                            .clipped()
                    }
                    
                    Spacer()
                }
            }
            
            
        }.padding()
    }
}

extension CreateTweetView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        
        postImage = Image(uiImage: selectedImage)
    }
}

