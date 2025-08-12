//
//  Medicine_TrackerApp.swift
//  Medicine Tracker
//
//  Created by admin on 6/29/23.
//

import SwiftUI

@main
struct Medicine_TrackerApp: App {
    
    @StateObject var medsViewModel: MedsViewModel = MedsViewModel()
        
    var body: some Scene {
        WindowGroup {
                MainView()
            .environmentObject(medsViewModel)
           
            
        }
            
            
        }
        
        }
    

