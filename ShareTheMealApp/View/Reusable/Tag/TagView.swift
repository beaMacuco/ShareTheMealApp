//
//  TagView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct TagView: View {
    let tag: String
    
    var body: some View {
        Text(tag)
            .padding(ViewSpacing.eight)
            .foregroundStyle(.white)
            .font(.footnote)
            .background(
                RoundedRectangle(cornerRadius: ViewSpacing.eight)
                    .fill(Color.black)
            )
            .accessibilityIdentifier(AccessibilityIdentifiers.mealProgramTagText)
    }
}

#Preview {
    TagView(tag: "emergency")
}
