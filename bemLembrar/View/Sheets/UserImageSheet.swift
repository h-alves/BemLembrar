//
//  UserImageSheet.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 16/11/23.
//

import SwiftUI

struct UserImageSheet: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                SheetLine()
                
                ScrollView {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Meu perfil")
                                .foregroundStyle(.preto)
                                .font(.title.title())
                                .fontWeight(.bold)
                            
                            Text("Como eu gostaria de ser chamada:")
                                .foregroundStyle(.preto)
                                .font(.title3.title3())
                                .fontWeight(.semibold)
                            
                            BLTextField(placeholderText: "Nome", text: $viewModel.name)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Meu ícone:")
                                .foregroundStyle(.preto)
                                .font(.title3.title3())
                                .fontWeight(.semibold)
                            
                            FlexStack(verticalSpacing: 16, horizontalSpacing: 16) {
                                ForEach(viewModel.images, id: \.self) { image in
                                    Button {
                                        viewModel.selectImage(image: image)
                                    } label: {
                                        Image(image)
                                            .resizable()
                                            .frame(width: 52, height: 52)
                                            .overlay {
                                                if viewModel.image == image {
                                                    ZStack {
                                                        Circle()
                                                            .foregroundStyle(.verdeEscuro.opacity(0.8))
                                                            .frame(width: 50, height: 50)
                                                        
                                                        Circle()
                                                            .stroke(.verdeEscuro, lineWidth: 2)
                                                            .frame(width: 50, height: 50)
                                                        
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
                                viewModel.saveImage()
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
    UserImageSheet(viewModel: UserViewModel())
}
