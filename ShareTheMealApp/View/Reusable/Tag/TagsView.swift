//
//  TagsView.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
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
