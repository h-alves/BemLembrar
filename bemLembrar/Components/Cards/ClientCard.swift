//
//  ClientCard.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct ClientCard: View {
    var client: Client
    var isEditing: Bool
    var mainFunc: () -> Void
    var deleteFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            HStack(alignment: .center) {
                HStack(spacing: 12) {
                    if isEditing {
                        Button {
                            deleteFunc()
                        } label: {
                            Image("\(client.image)Delete")
                                .resizable()
                                .frame(width: 46, height: 45)
                        }
                    } else {
                        Image(client.image)
                            .resizable()
                            .frame(width: 46, height: 45)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(client.fullName)")
                            .foregroundStyle(.verde)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        PreferencesTag(big: false, preferences: client.preferences)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.verde)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(.branco)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    ClientCard(client: Client.test, isEditing: false) {
        print("clicado")
    } deleteFunc: {
        print("apagado")
    }
}
