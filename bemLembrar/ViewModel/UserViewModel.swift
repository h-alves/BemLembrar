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
    
    @Published var brandIsEditing = false
    @Published var strategyIsEditing = false
    
    func selectBrand(brand: Brand) {
        for (index, originalBrand) in brands.enumerated() {
            if originalBrand == brand {
                brands[index].isSelected.toggle()
            }
        }
    }
    
    func saveBrands() {
        for (index, brand) in brands.enumerated() {
            UserData.shared.user.brands[index] = brand
        }
        
        brandIsEditing.toggle()
    }
    
    func selectStrategy(strategy: Strategy) {
        for (index, originalStrategy) in strategies.enumerated() {
            if originalStrategy == strategy {
                strategies[index].isSelected.toggle()
            }
        }
    }
    
    func saveStrategies() {
        for (index, strategy) in strategies.enumerated() {
            if UserData.shared.user.strategies[index].name == Strategy.comemorative.name {
                if !UserData.shared.user.strategies[index].isSelected && strategy.isSelected {
                    for i in ComemorativeDate.allDates {
                        NotificationManager.shared.scheduleComemorativeNotification(identifier: i.identifier, date: i.date, name: i.name)
                    }
                } else if UserData.shared.user.strategies[index].isSelected && !strategy.isSelected {
                    for i in ComemorativeDate.allDates {
                        NotificationManager.shared.cancelComemorativeNotification(identifier: i.identifier)
                    }
                }
            }
            
            UserData.shared.user.strategies[index] = strategy
        }
        
        strategyIsEditing.toggle()
    }
}
