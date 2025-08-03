//
//  BackButtonToolbarItem.swift
//  ShareTheMealApp
//
//

import SwiftUI

struct BackToolBarItem: ToolbarContent {
    var action: () -> ()
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton(action: action)
                .accessibilityIdentifier(AccessibilityIdentifiers.dismissButton)
        }
    }
 }
