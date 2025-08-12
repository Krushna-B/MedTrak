//
//  MedicinesViewModel.swift
//  Medicine Tracker
//
//  Created by admin on 7/2/23.
//

import Foundation
import SwiftUI

class MedsViewModel: ObservableObject {
    
    @Published var medsArray: [medicineModel] = []{
        didSet{
            savedMeds()
        }
    }
    
    @Published var daysOfTheWeek: [String] = []
    
    @Published var medsShowingOnHomeScreen: [medicineModel] = []
    

    init(){
        getItems()
  //     updateMedicinesAtMidnight()
    
    }
    
    func getItems() {
       guard let data = UserDefaults.standard.data(forKey: "SavedMeds") else { return }
       guard let savedMedicines = try? JSONDecoder().decode([medicineModel].self, from: data) else { return }

       self.medsArray = savedMedicines
   }
    
    func addMeds(name: String, Dosage: String, pillDate: Date, totalPills: String, remainingPill: String, daysOfTheWeek: [String], endDate: Date, isMedTaken: Bool){
        let newMed = medicineModel(title : name, Doasage: Dosage, pillDate: pillDate ,totalPill:totalPills, remainingPill: remainingPill, daysOfTheWeek: daysOfTheWeek, endDate: endDate, isMedTaken: isMedTaken)
        medsArray.append(newMed)
    }
    
    func deleteMeds(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let medicineToDeleteID = medsShowingOnHomeScreen[index].id
        
        if let medsArrayIndex = medsArray.firstIndex(where: {$0.id == medicineToDeleteID}) {
            medsArray.remove(at: medsArrayIndex)
        }
        
        medsShowingOnHomeScreen.remove(atOffsets: indexSet)
        
    }
    
    func moveMeds(from: IndexSet, to: Int){
        medsShowingOnHomeScreen.move(fromOffsets: from, toOffset: to)
    }
    func savedMeds(){
        if let encodedData = try? JSONEncoder().encode(medsArray){
            UserDefaults.standard.set(encodedData, forKey: "SavedMeds")
        }
    }
    
    func updateMedicinesAtMidnight(){
        let calendar = Calendar.current
        let currentDate = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())
        guard let tomorrowDate = tomorrow else { return }
        let components = calendar.dateComponents([.hour, .minute], from: currentDate)
        let hour = components.hour
        let minute = components.minute
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekTomorrow = dateFormatter.string(from: tomorrowDate)
        
        
       let daysOfTheWeekLeft = getRemainingWeekdays()
        
       if hour == 18 && minute == 43{
           medsArray = medsArray.filter { med in
               daysOfTheWeekLeft.contains { daysLeft in
                   med.daysOfTheWeek.contains(daysLeft)
               }
           }
           }
       }
    
    func getRemainingWeekdays() -> [String]{
        let weekdays = ["Sunday","Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday"]
        let calendar = Calendar.current
        var remainingWeekdays: [String] = []
        
        guard let today = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date())) else {
            return remainingWeekdays
        }
        let todayWeekday = calendar.component(.weekday, from: today)
        
        for i in todayWeekday..<weekdays.count{
            remainingWeekdays.append(weekdays[i])
        }
        return remainingWeekdays
    }
    
    func sortMeds() {
         medsShowingOnHomeScreen = medsShowingOnHomeScreen.sorted { (medicine1, medicine2) -> Bool in

             if medicine1.pillDate < medicine2.pillDate {
                return true
            } else{
                return false
            }
        }
        
    }
    
    func filterMedsArray(){
        let currentDate = Date()
         medsShowingOnHomeScreen = medsArray.filter { medicine in
            let isDayShowing = medicine.daysOfTheWeek.contains(dayOfTheWeek())
             let isStilActive = currentDate <= medicine.endDate
            return isDayShowing && isStilActive
            
        }
    }
    
    func dayOfTheWeek() -> String{
        let CurrentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: CurrentDate )
    }
    
//    func deleteMedsFromMainArray(indexSet: IndexSet){
//        
//        medsArray.remove(atOffsets: indexSet)
//        
//    }
//    
}
