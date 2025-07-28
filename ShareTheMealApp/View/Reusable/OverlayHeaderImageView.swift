//
//  OverlayHeaderImageView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

struct OverlayHeaderImageView: View {
    let title: String
    let imageUrl: URL?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = imageUrl {
                AsyncImage(url: url) { result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
            }
            Text(title)
                .foregroundStyle(.white)
                .padding(ViewSpacing.four)
                .background(.black)
        }
    }
}

#Preview {
    OverlayHeaderImageView(title: "Food donation program", imageUrl: URL(string: "www.test.com"))
}
