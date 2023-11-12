//
//  UserViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var name = UserData.shared.user.name
    @Published var image = UserData.shared.user.image
    @Published var brands = UserData.shared.user.brands
    @Published var strategies = UserData.shared.user.strategies
}
