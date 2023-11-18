//
//  ClientImageSheet.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 17/11/23.
//

import SwiftUI

struct ClientImageSheet: View {
    @ObservedObject var viewModel: ClientViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                SheetLine()
                
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Ícone de \(viewModel.client.fullName):")
                                .foregroundStyle(.preto)
                                .font(.title3.title3())
                                .fontWeight(.semibold)
                            
                            HStack(spacing: 15) {
                                ForEach(viewModel.images, id: \.self) { image in
                                    Button {
                                        viewModel.selectImage(image: image)
                                    } label: {
                                        Image(image)
                                            .resizable()
                                            .frame(width: 49, height: 48)
                                            .overlay {
                                                if viewModel.client.image == image {
                                                    ZStack {
                                                        RoundedRectangle(cornerRadius: 13)
                                                            .foregroundStyle(.verdeEscuro.opacity(0.8))
                                                            .frame(width: 47, height: 46)
                                                        
                                                        RoundedRectangle(cornerRadius: 13)
                                                            .stroke(.verdeEscuro, lineWidth: 2)
                                                            .frame(width: 47, height: 46)
                                                        
                                                        Image(systemName: "checkmark")
                                                            .foregroundStyle(.branco)
                                                            .font(.system(size: 23))
                                                            .fontWeight(.bold)
                                                    }
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            BLButton(symbol: "checkmark", text: "Salvar", infinity: false, disabled: false, opposite: false, color: .verde, textColor: .branco) {
                                viewModel.imageIsEditing.toggle()
                            }
                        }
                        
                        Spacer()
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 32)
        }
        .padding(.top, 12)
        .background(.branco)
        .presentationDetents([.medium])
    }
}

#Preview {
    ClientImageSheet(viewModel: ClientViewModel())
}
