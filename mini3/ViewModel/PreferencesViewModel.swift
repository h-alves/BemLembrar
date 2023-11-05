//
//  PreferencesViewModel.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import Foundation

class PreferencesViewModel: ObservableObject {
    @Published var allClients = ClientDataSource.shared.allClients
    
    func filterBySmell(cheiro: Cheiro) -> [Client] {
        let filteredList = allClients.filter { c in
            c.preferences.cheiro.contains(cheiro)
        }
        
        return filteredList
    }
    
    
}
