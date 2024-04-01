//
//  ProfileViewModel.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 28/3/24.
//

import SwiftUI

struct ProfileViewModel: Identifiable {
    let id = UUID()
    let profileImage = Image("stockProfilePhoto")
    let gridIcons = [
        Image("profileRandomIcon2"),
        Image("profileRandomIcon1"),
        Image("profileRandomIcon3"),
        Image("profileRandomIcon4"),
        Image("profileRandomIcon5"),
        Image("profileRandomIcon6")
    ]
}
