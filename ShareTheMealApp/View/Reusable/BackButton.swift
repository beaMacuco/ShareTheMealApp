//
//  BackButton.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

struct BackButton: View {
    var action: () -> ()
    
    var body: some View {
        IconButton(iconName: SFSymbols.arrowLeft, action: action)
    }
}

#Preview {
    BackButton {}
}
