//
//  PrimaryButton.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(.black)
                .padding(ViewSpacing.twelve)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .background(.yellow)
        .cornerRadius(ViewSpacing.eight)
    }
}

#Preview {
    PrimaryButton(title: "Click me") {}
}
