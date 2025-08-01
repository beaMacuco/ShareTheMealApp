//
//  TagsView.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct TagsView: View {
    let tags: [String]
    
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tag in
                TagView(tag: tag)
            }
        }
    }
}

#Preview {
    TagsView(tags: ["nutrition", "emergency", "food"])
}
