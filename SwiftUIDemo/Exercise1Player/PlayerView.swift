//
//  PlayerView.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 27/3/24.
//

import SwiftUI

struct PlayerView: View {
    @State private var selectedIndex: Int = 0
    let imageName = "musicBackground"
    let items = PlayerViewModel.apps
    @State private var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            VStack {
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width+2)
                            .offset(x: -2)
                            .clipped()
                        
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width+2)
                            .offset(x: -2)
                            .clipped()
                            .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                            .opacity(0.5)
                            .padding(.horizontal, max(geometry.safeAreaInsets.leading, geometry.safeAreaInsets.trailing)) // center the image
                    }.ignoresSafeArea(edges: .horizontal)
                }.overlay {
                    ProgressView(value: 0, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
                        .scaleEffect(x: 1, y: 4, anchor: .center)// Modifies size
                        .padding(.horizontal, 50)
                }
                
                
                // Buttons
                HStack(alignment: .bottom) {
                    Button(role: .none,
                           action: {
                        withAnimation {
                            selectedIndex = max(selectedIndex - 1, 0)
                        }
                    }, label: {
                        Image("arrowDownButton")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .rotationEffect(Angle(degrees: 180))
                    })
                    .frame(width: 55, height: 55)
                    
                    Spacer()
                    
                    Button(role: .none,
                           action: {
                        if selectedIndex < items.count {
                            path.append(items[selectedIndex].selectedView)
                        }
                        
                    }, label: {
                        ZStack {
                            Text("GO")
                                .foregroundStyle(.black)
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                            Image("blackCircle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    })
                    .frame(width: 120, height: 120)
                    
                    
                    
                    
                    Spacer()
                    
                    Button(role: .none,
                           action: {
                        withAnimation {
                            selectedIndex = min(selectedIndex + 1, items.count - 1)
                        }
                    }, label: {
                        Image("arrowDownButton")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    })
                    .frame(width: 55, height: 55)
                }.frame(width: 300)
                    .padding()
                
                // List
                ScrollViewReader { value in
                    List {
                        ForEach(items.indices, id: \.self) { index in
                            ImageCell(appSelector: items[index])
                                .frame(height: ImageCell.height)
                                .id(index)
                                .listRowBackground(Color.clear) // Set the background of the list row to clear
                        }
                    }
                    .listStyle(.plain)
                    .frame(height: ImageCell.height)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 25)
                    .background(Color.clear)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                    .clipped()
                    .onChange(of: selectedIndex) { _, newIndex in
                        withAnimation {
                            value.scrollTo(newIndex, anchor: .center)
                        }
                    }
                    .onAppear {
                        UIScrollView.appearance().isScrollEnabled = false
                        value.scrollTo(selectedIndex, anchor: .center)
                    }
                }

            }
            .navigationBarTitle("Weather View", displayMode: .inline)
            .navigationDestination(for: PlayerViewModel.NextView.self) { view in
                
                switch view {
                    case .weather:
                        WeatherView()
                    case .taskList:
                        TaskListView()
                    case .profile:
                        ProfileView()
                    case .heroes:
                        HeroesView()
                }
            }
        }.clipShape(RoundedRectangle(cornerSize: CGSize(width: 35, height: 35))).padding().containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.blue, .red, .purple]).opacity(0.6))
            .overlay {
                ZStack {
                    ForEach([15, 13, 8, 5, 5, 5, 2], id: \.self) { width in
                        GradientRectangle(lineWidth: width)
                    }
                }
            }
    }
}

struct GradientRectangle: View {
    var lineWidth: CGFloat

    var body: some View {
        Rectangle()
            .stroke(lineWidth: lineWidth)
            .blur(radius: 15)
            .foregroundStyle(Gradient(colors: [.blue, .red, .purple]))
    }
}

struct ImageCell: View {
    static let height: CGFloat = 100
    let appSelector: PlayerViewModel.PlayerAppSelectorViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let image = appSelector.backgroundImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                        .clipped()
                }
                
                Text(appSelector.title)
                    .font(.system(.title, design: .rounded))
                    .foregroundStyle(.black)
                    .background {
                        Rectangle().foregroundStyle(.white.opacity(0.7))
                            .frame(width: geometry.size.width)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
