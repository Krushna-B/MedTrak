//
//  ContentView.swift
//  Medicine Tracker
//
//  Created by admin on 6/29/23.
//

import SwiftUI


struct MainView: View {
    
    @State private var isAppInstalled:Bool = false
   
    var body: some View {
        NavigationStack{
            Group{
                if isAppInstalled{
                    StartView()
                        
                } else{
                    
                    HomeView()
                }
                
            }
            .onAppear{
                if !isAppInstalled{
                    isAppInstalled = true
                    UserDefaults.standard.set(true, forKey: "isAppInstalled")
                   
                }
            
            }
          
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
