//
//  RejectedView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct RejectedView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Precisamos de acesso aos seus contatos para adicionar clientes")
                .multilineTextAlignment(.center)
            
            Button {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            } label: {
                Text("Ir para as configurações")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    RejectedView()
}
