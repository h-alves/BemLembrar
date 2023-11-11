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
            HStack {
                HStack(spacing: 12) {
                    if isEditing {
                        Button {
                            deleteFunc()
                        } label: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                
                                Image(systemName: "x.circle.fill")
                                    .foregroundStyle(.red)
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                            }
                        }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 42, height: 42)
                            .foregroundStyle(.black)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(client.fullName)")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        
                        PreferencesTag(big: false, preferences: client.preferences)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.gray)
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
