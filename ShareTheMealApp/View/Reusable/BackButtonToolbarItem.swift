//
//  BackButtonToolbarItem.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

struct BackToolBarItem: ToolbarContent {
    var action: () -> ()
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton(action: action)
        }
    }
 }
