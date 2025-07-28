//
//  IconButton.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 27.07.25.
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
