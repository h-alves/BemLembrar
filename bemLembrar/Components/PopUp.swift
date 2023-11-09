//
//  PopUp.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct PopUp: View {
    var title: String
    var bodyText: String
    var buttonText: String
    var secondaryText: String
    
    var mainFunc: () -> Void
    var secondaryFunc: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Text(title)
                    Text(bodyText)
                }
                
                HStack {
                    Button {
                        secondaryFunc()
                    } label: {
                        Text(secondaryText)
                    }
                    
                    Button {
                        mainFunc()
                    } label: {
                        Text(buttonText)
                    }
                }
            }
        }
    }
}

#Preview {
    PopUp(title: "teste", bodyText: "teste", buttonText: "teste", secondaryText: "teste") {
        print("a")
    } secondaryFunc: {
        print("b")
    }
}
