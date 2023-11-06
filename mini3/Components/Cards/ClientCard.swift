//
//  ClientCard.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct ClientCard: View {
    var client: Client
    var mainFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            HStack {
                HStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .foregroundStyle(.black)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(client.fullName)")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        
                        PreferencesTags(smaller: true, preferences: client.preferences)
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
    ClientCard(client: Client.test) {
        print("clicado")
    }
}
