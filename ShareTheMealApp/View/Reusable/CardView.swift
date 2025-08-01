//
//  CardView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct CardView<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewSpacing.twelve) {
            content
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: ViewSpacing.eight))
        .shadow(radius: ViewSpacing.four)
        .padding(ViewSpacing.sixteen)
    }
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

#Preview {
    CardView() {}
}
