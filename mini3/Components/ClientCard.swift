//
//  ClientCard.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct ClientCard: View {
    var client: Client
    
    var body: some View {
        Button {
            print("Clicado")
        } label: {
            HStack {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .foregroundStyle(.black)
                    
                    VStack {
                        Text("\(client.contactInfo.givenName) \(client.contactInfo.familyName)")
                            .foregroundStyle(.black)
                        
                        // HStack com ForEach de todas as preferências
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
    ClientCard(client: Client.test)
}
