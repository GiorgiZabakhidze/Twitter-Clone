//
//  SearchCell.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct SearchCell: View {
    var tag = ""
    var tweets = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(tag)
                .fontWeight(.heavy)
            Text(tweets + " Tweets")
                .fontWeight(.light)
        }
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell()
    }
}
