//
//  HomeView.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Button {
            RouterService.shared.navigate(.allClients)
        } label: {
            Text("Home")
        }
    }
}

#Preview {
    HomeView()
}
