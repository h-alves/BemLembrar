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
        HStack(spacing: 4) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText == "" ? .verdeClaro : .preto)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            TextField("Pesquisar", text: $searchText)
                .font(.title3.title3())
                .fontWeight(.semibold)
                .foregroundStyle(.preto)
                .overlay(
                    Image(systemName:"xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(searchText == "" ? .verdeClaro : .preto)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
                .onChange(of: searchText, perform: { value in
                    mainFunc()
                })
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(searchText.isEmpty ? .rosa : .verde, lineWidth: 2)
        )
    }
}

#Preview {
    SearchBar(searchText: .constant("")) {
        print("a")
    }
}
