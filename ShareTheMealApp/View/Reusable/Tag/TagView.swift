//
//  TagView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
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
    }
}

#Preview {
    TagView(tag: "emergency")
}
