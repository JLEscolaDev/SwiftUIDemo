//
//  HeroesView.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 28/3/24.
//

import SwiftUI

struct HeroesView: View {
    @ObservedObject var viewModel = HeroesViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.heroes) { hero in
                    NavigationLink(destination: HeroeDetailView(heroe: hero)) {
                        HStack {
                            if let imageName = hero.imagen, let uiImage = UIImage(named: imageName) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 40, height: 40)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(hero.apodo).font(.headline)
                                Text(hero.nombreReal).font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.removeHeroe)
                .onMove(perform: viewModel.moveHeroe)
            }
            .navigationBarTitle("Heroes")
            .navigationBarItems(trailing: EditButton())
        }
    }
}


#Preview {
    HeroesView()
}
struct HeroeDetailView: View {
    var heroe: Heroe

    var body: some View {
        Form {
            Section() {
                HStack {
                    Spacer()
                    if let imageName = heroe.imagen, let uiImage = UIImage(named: imageName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    } else {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 200, height: 200)
                    }
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            
            Section {
                HStack {
                    Text("Apodo")
                    Spacer()
                    Text(heroe.apodo)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                HStack {
                    Text("Nombre real")
                    Spacer()
                    Text(heroe.nombreReal)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                HStack {
                    Text("Edad")
                    Spacer()
                    Text("\(heroe.edad)")
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
            
            Section(header: Text("Poderes")) {
                Text(heroe.poderes.map { $0.rawValue }.formatted(.list(type: .and)))
            }
            
            Section(header: Text("Descripción")) {
                Text(heroe.descripcion ?? "No description")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(heroe.apodo)
    }
}
