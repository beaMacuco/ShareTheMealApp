//
//  IconButton.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct IconButton: View {
    let iconName: String
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: iconName)
        }
        .tint(.white)
    }
}

#Preview {
    IconButton(iconName: SFSymbols.search) {}
}
