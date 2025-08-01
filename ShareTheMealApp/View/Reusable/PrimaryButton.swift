//
//  PrimaryButton.swift
//  ShareTheMealApp
//
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
