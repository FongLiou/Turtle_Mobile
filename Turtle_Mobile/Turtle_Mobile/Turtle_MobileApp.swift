//
//  Turtle_MobileApp.swift
//  Turtle_Mobile
//
//  Created by Mac2_iparknow on 2023/12/12.
//

import SwiftUI

@main
struct Turtle_MobileApp: App {
    @StateObject private var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
