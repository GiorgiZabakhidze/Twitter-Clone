//
//  searchUserCell.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

struct searchUserCell: View {
    var body: some View {
        HStack {
            Image("profile_pic")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("zabaxa")
                    .fontWeight(.heavy)
                Text("@Giorgi_Zabakhidze")
            }
            Spacer(minLength: 0)
        }
    }
}

struct searchUserCell_Previews: PreviewProvider {
    static var previews: some View {
        searchUserCell()
    }
}
