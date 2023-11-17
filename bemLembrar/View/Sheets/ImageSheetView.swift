//
//  ImageSheetView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 16/11/23.
//

import SwiftUI

struct ImageSheetView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("Imagens")
            
            HStack {
                ForEach(viewModel.images, id: \.self) { image in
                    Button {
                        viewModel.selectImage(image: image)
                    } label: {
                        ZStack {
                            Image(image)
                                .overlay(alignment: .bottomTrailing) {
                                    if viewModel.image == image {
                                        ZStack {
                                            Image(systemName: "circle.fill")
                                                .foregroundStyle(.branco)
                                                .font(.system(size: 32))
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(.verde)
                                                .font(.system(size: 32))
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            
            Button {
                viewModel.imageIsEditing.toggle()
            } label: {
                Text("Done")
            }
        }
    }
}

#Preview {
    ImageSheetView(viewModel: UserViewModel())
}
