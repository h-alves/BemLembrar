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
    @Published var strategies = Strategy.allStrategies.refactor()
    @Published var twoTwoTwo = UserData.shared.user.twoTwoTwo
    @Published var comemorative = UserData.shared.user.comemorative
    
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
            } else {
                strategies[index].isSelected = false
            }
        }
    }
    
    func saveStrategies() {
        UserData.shared.user.strategy = getStrategy()
        
        UserData.shared.user.twoTwoTwo = twoTwoTwo
        
        setComemorativeNotification()
        
        UserData.shared.user.comemorative = comemorative
        
        strategyIsEditing.toggle()
    }
    
    func getStrategy() -> Strategy {
        for strategy in strategies {
            if strategy.isSelected {
                return strategy
            }
        }
        return .none
    }
    
    func setComemorativeNotification() {
        if !UserData.shared.user.comemorative && comemorative {
            for i in ComemorativeDate.allDates {
                NotificationManager.shared.scheduleComemorativeNotification(identifier: i.identifier, date: i.date, name: i.name)
            }
        } else if UserData.shared.user.comemorative && !comemorative {
            for i in ComemorativeDate.allDates {
                NotificationManager.shared.cancelComemorativeNotification(identifier: i.identifier)
            }
        }
    }
}
