//
//  Tab Bar.swift
//  Medicine Tracker
//
//  Created by admin on 7/1/23.
//

import SwiftUI

struct tabBar: View {
    
    let tabBarItems: [(String)] = ["house","calendar", "list.dash"]
    var buttonState: [Bool]  = [false,false, false ]
    @State private var isHomeButtonHit: Bool = false
    @State private var isCalendarButtonHit: Bool = false
    @State private var isListButtonHit: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Capsule()
                    .frame(width:300, height: 60)
                    .foregroundColor(Color.blue).opacity(1.0)
                
                
                HStack(spacing: 50){
                    ForEach(0..<3){ index in
                        Button {
                            if(index == 0){
                                isHomeButtonHit = true
                            } else if( index == 1){
                                isCalendarButtonHit = true
                            } else if( index == 2){
                                isListButtonHit = true
                            }
                        } label: {
                            Image(systemName: tabBarItems[index])
                                .font(.system(size:25))
                                .foregroundColor(Color.white
                                )
                        }
                        
                    }
                    
                }
                
                
                
            }
            .navigationDestination(isPresented: $isHomeButtonHit) {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $isCalendarButtonHit) {
                Calender_View()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $isListButtonHit) {
                AllMeds()
                    .navigationBarBackButtonHidden(true)
            }
            
            
            }
            
        }
    
    }



struct tabBar_Previews: PreviewProvider {
    static var previews: some View {
        tabBar()
    }
}
