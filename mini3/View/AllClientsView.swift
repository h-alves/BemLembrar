//
//  AllClientsView.swift
//  mini3
//
//  Created by Gabriel Bruno Meira on 01/11/23.
//

import SwiftUI

struct AllClientsView: View {
    @ObservedObject var viewModel = AllClientsViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment:.leading) {
                
                Spacer()
                
                Text("Meus Clientes")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                
                HStack {
                    SearchBar(searchText: $viewModel.searchText) {
                        print("a")
                    }
                    
                    Button(action: {
                        RouterService.shared.navigate(.addClient)
                    }) {
                        Text("+ Adicionar")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(Color(.systemGray2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .frame(width: 116, height: 42)
                }
                .padding(.bottom, 21)
            }
            .frame(height: 140)
            .padding(.horizontal, 32)
            .background(Color(.systemGray6))
            
            VStack {
                ForEach(viewModel.allClients, id: \.contactInfo.identifier) { client in
                    ClientCard(client: client)
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 32)
            
            Spacer()
        }
        .onAppear {
            viewModel.testContact()
        }
    }
}

#Preview {
    AllClientsView()
}
