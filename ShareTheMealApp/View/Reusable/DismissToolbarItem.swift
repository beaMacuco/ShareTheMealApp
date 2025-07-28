//
//  DismissToolbarItem.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 27.07.25.
//

import SwiftUI

struct DismissToolbarItem: ToolbarContent {
    var onDismiss: () -> ()
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            DismissButton(onDismiss: onDismiss)
        }
    }
}
