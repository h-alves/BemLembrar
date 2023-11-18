//
//  UserViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var name = UserData.shared.user.name
    @Published var image = UserData.shared.user.image
    @Published var images = [String]()
    @Published var brands = UserData.shared.user.brands
    @Published var strategies = Strategy.allStrategies.refactor()
    
    @Published var imageIsEditing = false
    @Published var brandIsEditing = false
    @Published var strategyIsEditing = false
    
    func getImageList() {
        for i in 1...10 {
            images.append("userImage\(i)")
        }
        
        print(images)
    }
    
    func selectImage(image: String) {
        self.image = image
    }
    
    func saveImage() {
        UserData.shared.user.image = image
        UserData.shared.user.name = name
        
        imageIsEditing.toggle()
    }
    
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
                strategies[index].isSelected = true
            } else {
                strategies[index].isSelected = false
            }
        }
    }
    
    func saveStrategies() {
        UserData.shared.user.strategy = getStrategy()
        
        if UserData.shared.user.strategy.name == "2+2+2" {
            UserData.shared.user.twoTwoTwo = true
        } else {
            UserData.shared.user.twoTwoTwo = false
        }
        
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
        for i in ComemorativeDate.allDates {
            NotificationManager.shared.scheduleComemorativeNotification(identifier: i.identifier, date: i.date, name: i.name)
        }
    }
    
    func getBrandBinding(brand: Brand) -> Binding<Bool?> {
        let b = Binding<Bool?> {
            brand.isSelected
        } set: { v in
            if let v {
                let index = self.brands.firstIndex(of: brand)!
                self.brands[index].isSelected = v
            }
        }
        
        return b
    }
    
    func getStrategyBinding(strategy: Strategy) -> Binding<Bool?> {
        let b = Binding<Bool?> {
            strategy.isSelected
        } set: { v in
            if let v {
                let index = self.strategies.firstIndex(of: strategy)!
                self.strategies[index].isSelected = v
            }
        }
        
        return b
    }
    
    func isDisabled() -> Bool {
        if name == "" || strategies.allSatisfy({ s in
            !s.isSelected
        }) || brands.allSatisfy({ b in
            !b.isSelected
        }) {
            return true
        } else {
            return false
        }
    }
    
    func registerUser() {
        UserData.shared.user.name = name
        
        for (index, brand) in brands.enumerated() {
            UserData.shared.user.brands[index] = brand
        }
        
        UserData.shared.user.strategy = getStrategy()
        
        if UserData.shared.user.strategy.name == "2+2+2" {
            UserData.shared.user.twoTwoTwo = true
        } else {
            UserData.shared.user.twoTwoTwo = false
        }
        
        setComemorativeNotification()
    }
}
