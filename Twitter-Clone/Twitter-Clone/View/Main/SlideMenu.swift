//
//  SlideMenu.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

struct SlideMenu: View {
    @State var show = false
    
    var body: some View {
        VStack {
            HStack(spacing: 0){
                VStack(alignment: .leading) {
                    Image("profile_pic")
                        .resizable()
                        .frame(width: 60,height: 60)
                        .clipShape(Circle())
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 12) {
                             Text("zabaxa")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Text("@Giorgi_Zabakhidze")
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 20) {
                                FollowView(count: 8, title: "Followers")
                                FollowView(count: 16, title: "Folloing")
                            }.padding(.top, 10)
                            Divider()
                                .padding(.top, 10)
                            
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            withAnimation {
                                self.show.toggle()
                            }
                        } label: {
                            Image(systemName: show ? "chevron.down" : "chevron.up")
                                    .foregroundColor(Color("bg"))
                        }
                    }
                }
            }
        }
    }
}

struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenu()
    }
}
