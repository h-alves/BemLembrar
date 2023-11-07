//
//  SearchBar.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import Combine
import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var mainFunc: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
            
            TextField("Pesquisar", text: $searchText)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .overlay(
                    Image(systemName:"xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(.gray)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
                .onChange(of: searchText) { oldValue, newValue in
                    mainFunc()
                }
        }
        .padding(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 2)
        )
    }
}

#Preview {
    SearchBar(searchText: .constant("")) {
        print("a")
    }
}
