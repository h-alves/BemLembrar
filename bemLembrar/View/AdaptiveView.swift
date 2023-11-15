//
//  AdptativeImage.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 15/11/23.
//

import SwiftUI

struct AdaptiveView<T: View, U: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let light: T
    let dark: U

    init(light: T, dark: U) {
        self.light = light
        self.dark = dark
    }

    init(light: () -> T, dark: () -> U) {
        self.light = light()
        self.dark = dark()
    }

    @ViewBuilder var body: some View {
        if colorScheme == .light {
            light
        } else {
            dark
        }
    }
}
