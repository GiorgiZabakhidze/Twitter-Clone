//
//  TopBar.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

struct TopBar: View {
    @Binding var x: CGFloat
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        x = 0
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundColor(Color("bg"))
                }
                
                Image("twitter")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .padding(.leading, width/3.1)
                Spacer(minLength: 0)
                
            }.padding()
            
            
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
            
        }.background(.white)
    }
}

