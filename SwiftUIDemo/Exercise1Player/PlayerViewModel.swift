//
//  PlayerViewModel.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 27/3/24.
//

import UIKit

struct PlayerViewModel {
    struct PlayerAppSelectorViewModel {
        let title: String
        let backgroundImage: UIImage?
        let selectedView: NextView
    }
    
    enum NextView {
        case weather
        case profile
        case taskList
        case heroes
    }
    
    static let apps: [PlayerAppSelectorViewModel] = [
        PlayerAppSelectorViewModel(
            title: "Weather view",
            backgroundImage: UIImage(
                named: "weatherBackground"
            ),
            selectedView: .weather
        ),
        PlayerAppSelectorViewModel(
            title:"Task list",
            backgroundImage: UIImage(
                named: "tasksBackground"
            ),
            selectedView: .taskList
        ),
        PlayerAppSelectorViewModel(
            title:"Profile",
            backgroundImage: UIImage(
                named: "profileBackground"
            ),
            selectedView: .profile
        ),
        PlayerAppSelectorViewModel(
            title:"Superheroes",
            backgroundImage: UIImage(
                named: "heroesBackground"
            ),
            selectedView: .heroes
        )
        
    ]
}
