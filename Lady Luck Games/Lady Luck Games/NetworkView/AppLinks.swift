//
//  AppLinks.swift
//  Lady Luck Games
//
//  Created by Dias Atudinov on 07.02.2025.
//


import SwiftUI

class AppLinks {
    
    static let shared = AppLinks()
    
    static let winStarData = "https://google.com"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
