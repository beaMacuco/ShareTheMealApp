//
//  OverlayHeaderImageView.swift
//  ShareTheMealApp
//
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
                .accessibilityIdentifier(AccessibilityIdentifiers.overlayImageView)
            Text(title)
                .foregroundStyle(.white)
                .padding(ViewSpacing.four)
                .background(.black)
                .accessibilityIdentifier(AccessibilityIdentifiers.overlayHeaderView)
        }
    }
}

#Preview {
    OverlayHeaderImageView(title: "Food donation program", image: Image("ImagePlaceholder"))
}
