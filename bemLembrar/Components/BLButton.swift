//
//  BLButton.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 13/11/23.
//

import SwiftUI

struct BLButton: View {
    var symbol: String
    var font: Font = .headline
    var text: String = ""
    var infinity: Bool = true
    var disabled: Bool
    var opposite: Bool
    var color: Color
    var textColor: Color
    var mainFunc: () -> Void
    
    var body: some View {
        if infinity {
            Button {
                mainFunc()
            } label: {
                HStack {
                    if opposite {
                        if text != "" {
                            Text(text)
                                .foregroundStyle(getTextColor())
                                .font(font)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Image(systemName: getSymbol())
                        .foregroundStyle(getTextColor())
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    if !opposite {
                        if text != "" {
                            Text(text)
                                .foregroundStyle(getTextColor())
                                .font(font)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(backgroundColor())
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .disabled(disabled)
        } else {
            Button {
                mainFunc()
            } label: {
                HStack {
                    if opposite {
                        if text != "" {
                            Text(text)
                                .foregroundStyle(getTextColor())
                                .font(font)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Image(systemName: getSymbol())
                        .foregroundStyle(getTextColor())
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    if !opposite {
                        if text != "" {
                            Text(text)
                                .foregroundStyle(getTextColor())
                                .font(font)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(backgroundColor())
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .disabled(disabled)
        }
    }
    
    func backgroundColor() -> Color {
        if disabled {
            return .verdeClaro
        }
        return color
    }
    
    func getTextColor() -> Color {
        if disabled {
            return .verdeOpaco
        }
        return textColor
    }
    
    func getSymbol() -> String {
        if disabled {
            return "lock.fill"
        }
        return symbol
    }
}

#Preview {
    VStack {
        BLButton(symbol: "circle", text: "Teste", disabled: true, opposite: false, color: .verde, textColor: .branco) {
            print("Clicado")
        }
        HStack {
            SearchBar(searchText: .constant("")) {
                print("teste")
            }
            
            BLButton(symbol: "plus", disabled: false, opposite: false, color: .rosa, textColor: .verde) {
                print("Clicado")
            }
        }
        BLButton(symbol: "circle", text: "Teste", disabled: false, opposite: false, color: .verde, textColor: .branco) {
            print("Clicado")
        }
        BLButton(symbol: "circle", text: "Teste", disabled: false, opposite: true, color: .rosa, textColor: .verde) {
            print("Clicado")
        }
        BLButton(symbol: "circle", text: "Teste", disabled: false, opposite: true, color: .branco, textColor: .rosaEscuro) {
            print("Clicado")
        }
    }
}
