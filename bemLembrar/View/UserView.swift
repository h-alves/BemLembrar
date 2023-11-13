//
//  UserView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(viewModel.name)
                
                HStack {
                    ForEach(viewModel.brands, id: \.name) { brand in
                        if brand.isSelected {
                            Text(brand.name)
                        }
                    }
                    
                    Button {
                        viewModel.brandIsEditing.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
                
                HStack {
                    if UserData.shared.user.strategy != .none {
                        Text(UserData.shared.user.strategy.name)
                    }
                    
                    if UserData.shared.user.twoTwoTwo {
                        Text(Strategy.twoTwoTwo.name)
                    }
                    
                    if UserData.shared.user.comemorative {
                        Text(Strategy.comemorative.name)
                    }
                    
                    Button {
                        viewModel.strategyIsEditing.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        RouterService.shared.navigate(.allClients)
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                    }
                }
            }
            .sheet(isPresented: $viewModel.brandIsEditing) {
                BrandsSheetView(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.strategyIsEditing) {
                StrategySheetView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    UserView()
}
