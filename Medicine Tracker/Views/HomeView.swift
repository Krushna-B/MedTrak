//
//  HomeView.swift
//  Medicine Tracker
//
//  Created by admin on 6/29/23.
//
import UIKit
import SwiftUI

struct HomeView: View {
    let backgroundColor = Color(red: 242/255, green: 242/255, blue: 247/255)
    @State private var greeting:String = ""
    @State private var isPlusButtonHit: Bool = false
    @EnvironmentObject var medsViewModel: MedsViewModel
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor.ignoresSafeArea()
                
                VStack{
                    HStack{
                        
                    }
                   
                    List(){
                        Section {
                            ForEach(medsViewModel.medsShowingOnHomeScreen.prefix(4)){ med in
                                ListRowView(meds: med)
                                    
                                

                            }
                            .onDelete(perform: medsViewModel.deleteMeds)
                            .onMove(perform: medsViewModel.moveMeds)
                        }
                        header: {
                            Text("Medicines for Today")
                                .font(.title2)
                                .foregroundColor(.black)
                                .textCase(.none)
                        }

                    }
                    .listRowSeparator(.hidden)
                    .listStyle(DefaultListStyle())
                    
                   
                    
                    .navigationTitle(greeting + GetStarted().firstName).foregroundColor(Color.blue)
                    .navigationBarTitleDisplayMode(.automatic)
                    .onAppear{
                     //   NotificationManager.instance.requestAutherization()
                        greetingChanger()
                        medsViewModel.filterMedsArray()
                        medsViewModel.sortMeds()
                        
                    }
                    
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text(getCurrentDate()).bold().font(.system(size: 16))
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                isPlusButtonHit = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .font(Font.system(size:16, weight: .regular)).bold()
                            }
                            
                        }
                    }
                    Spacer()
                    tabBar()
                }
            }
            .navigationDestination(isPresented: $isPlusButtonHit) {
                AddMeds_View()
                    .navigationBarBackButtonHidden(true)
            }
            
        }
        
    }
        
        
        func getCurrentDate() -> String{     //function returns current date for the header
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            return dateFormatter.string(from: currentDate)
        }
        
        func greetingChanger() {  // updates the greeting  based on the time of day
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: Date())
            
            
            if hour >= 6 && hour < 12{
                greeting = "Good Morning "
            } else if hour < 17 && hour >= 6 {
                greeting = "Good Afternoon "
            } else if hour < 21 && hour >= 6 {
                greeting = "Good Evening "
            } else {
                greeting = "Good Night "
            }
            
        }
    
   
    }






struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
