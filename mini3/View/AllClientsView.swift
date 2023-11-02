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
        VStack(alignment:.leading) {
            
            Spacer()
            
            Text("Meus Clientes")
                .font(.system(size: 32))
                .bold()
                .multilineTextAlignment(.leading)
            
            
            HStack {
                SearchBar(searchText: $viewModel.searchText) {
                    print("a")
                }
                
                Button(action: {
                    RouterService.shared.navigate(.addClient)
                }) {
                    Text("+ Adicionar")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color(.systemGray2))
                        .cornerRadius(10)
                }
                .frame(width: 116, height: 42)
            }
            .padding(.bottom, 21)
        }
        .padding(.horizontal, 32)
        .frame(height: 185)
        .background(Color(.systemGray6))
        .ignoresSafeArea()
        
        VStack(alignment:.leading) {
            Spacer()
        }
        
    }
}

#Preview {
    AllClientsView()
}
