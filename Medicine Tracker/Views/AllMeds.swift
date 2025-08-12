//
//  AllMeds.swift
//  Medicine Tracker
//
//  Created by admin on 7/5/23.
//

import SwiftUI

struct AllMeds: View {
    let backgroundColor = Color(red: 242/255, green: 242/255, blue: 247/255)
    @EnvironmentObject var medsViewModel: MedsViewModel
    let daysOfTheWeek = ["Monday","Tuesday", "Wednesday", "Thursday","Friday","Saturday","Sunday"]
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor.ignoresSafeArea()
                VStack{
                    
                    List() {
                        ForEach(daysOfTheWeek, id: \.self) { day in
                            Section{
                                ForEach(medsViewModel.medsArray){ med in
                                    if med.daysOfTheWeek.contains(day){
                                        ListRowView(meds: med)
                                    }
                                    
                                }
//                                .onDelete(perform: medsViewModel.deleteMedsFromMainArray)
                            }
                        header: {
                            Text(day)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                            
                        }
                    }
                    .navigationTitle("Medicines for the Week")
                    
                    
                    tabBar()
                }
            }
        }
    }
}
    


struct AllMeds_Previews: PreviewProvider {
    static var previews: some View {
        AllMeds()
    }
}
