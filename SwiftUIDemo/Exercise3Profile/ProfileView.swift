//
//  ProfileView.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 28/3/24.
//

import SwiftUI

struct ProfileView: View {
    let flexibleItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    let profileVM = ProfileViewModel()
    
    var body: some View {
        NavigationView {
                ScrollView {
                    VStack {
                        Text("Federico García")
                            .font(.title)
                            .padding(.top)
                        Image("stockProfilePhoto")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 4))
                    }
                    .padding()
                    
                    VStack(spacing: 20) {
                        NavigationLink {
                            Text("Es sólo una pantalla de demo 👍🏻")
                        } label: {
                            HStack {
                                Text("Texto de ejemplo :D")
                                Spacer()
                                Image(systemName: "info.circle").foregroundStyle(.blue)
                            }
                            
                        }
                        .buttonStyle(.plain)
                        
                        Divider()
                        
                        HStack {
                            Text("Tlf de contacto")
                            Spacer()
                            Text("123456789")
                        }
                        
                        Divider()
                        
                        LazyVGrid(columns: flexibleItems, spacing: 20) {
                            ForEach(0..<profileVM.gridIcons.count, id: \.self) { iconIndex in
                                profileVM.gridIcons[iconIndex]
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 100)
                                    .fixedSize(horizontal: false, vertical: false)
                                }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Unidades preferidas")
                            Spacer()
                            Text("km/h")
                        }
                    }
                    
                    
                }.padding(.horizontal, 16)
                    .scrollBounceBehavior(.basedOnSize)
            .navigationBarTitle("Back", displayMode: .inline)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    ProfileView()
}
