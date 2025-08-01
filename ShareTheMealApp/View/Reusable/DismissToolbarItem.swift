//
//  DismissToolbarItem.swift
//  ShareTheMealApp
//
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
