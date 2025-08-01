//
//  BackButton.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct BackButton: View {
    var action: () -> ()
    
    var body: some View {
        IconButton(iconName: SFSymbols.arrowLeft, action: action)
            .foregroundStyle(.black)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
    }
}

#Preview {
    BackButton {}
}
