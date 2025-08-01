//
//  DismissButton.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct DismissButton: View {
    var onDismiss: () -> ()
    
    var body: some View {
        IconButton(iconName: SFSymbols.dismiss) {
            onDismiss()
        }
    }
}
#Preview {
    DismissButton(onDismiss: {})
}
