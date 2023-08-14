//
//  UserProfile.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 13/8/23.
//

import SwiftUI

struct UserProfile: View {
    @State var offset: CGFloat = 0
    @State var titleOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                GeometryReader { proxy -> AnyView in
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return AnyView(
                        ZStack {
                            Image("banner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: minY > 0 ? 180 + minY : 180)
                                .cornerRadius(0)
                            BlurView()
                                .opacity(blurViewOpacity())
                            VStack(spacing: 5) {
                                Text("zabaxa")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("150 Tweets")
                                    .foregroundColor(.white)
                            }
                            .offset(y: 120)
                            .offset(y: titleOffset > 100 ? 0 : -getTitleOffset())
                            .opacity(titleOffset < 100 ? 1 : 0)
                        }
                        .clipped()
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                            
                    )
                }
                .frame(height: 180)
                .zIndex(1)
                
                VStack {
                    HStack {
                        Image("profile_pic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white)
                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                            .scaleEffect(getScale())
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Edit Profile")
                                .foregroundColor(.blue)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(Capsule()
                                    .stroke(Color.blue, lineWidth: 1.5))
                        }

                    }
                    .padding(.top, -25)
                    .padding(.bottom, -10)
                    
                    VStack(alignment: .leading, spacing:  8) {
                        Text("zabaxa")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("@Giorgi_Zabakhidze")
                            .foregroundColor(.gray)
                        Text("Let everything go, see what stays back. That’s yours.")
                        
                        HStack(spacing: 5) {
                            Text("8")
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                            Text("Follower")
                                .foregroundColor(.gray)
                            Text("16")
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                                .padding(.leading, 10)
                            Text("Following")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
    
    func blurViewOpacity() -> Double {
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
    
    func getTitleOffset() -> CGFloat {
        let progress = 20 / titleOffset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }
    
    func getOffset() -> CGFloat {
        let progress = -offset / 80 * 20
        return progress <= 20 ? progress : 20
    }
    
    func getScale() -> CGFloat {
        let progress = -offset/80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        return scale < 1 ? scale : 1
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
