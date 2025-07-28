//
//  DismissButton.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 27.07.25.
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
