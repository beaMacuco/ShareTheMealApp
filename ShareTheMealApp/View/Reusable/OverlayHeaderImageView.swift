//
//  OverlayHeaderImageView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

struct OverlayHeaderImageView: View {
    let title: String
    let image: Image
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            image
                .resizable()
                .scaledToFill()
            Text(title)
                .foregroundStyle(.white)
                .padding(ViewSpacing.four)
                .background(.black)
        }
    }
}

#Preview {
    OverlayHeaderImageView(title: "Food donation program", image: Image("ImagePlaceholder"))
}
