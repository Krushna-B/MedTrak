//
//  AddMeds View.swift
//  Medicine Tracker
//
//  Created by admin on 7/1/23.
//

import SwiftUI

struct AddMeds_View: View {
    let backgroundColor = Color(red: 242/255, green: 242/255, blue: 247/255)
    @State private var pillImage: Image = Image("Pills")
    @State public var isSaveButtonHit: Bool = false
    @State public var name: String = ""
    @State public var dosage: String = ""
    @State public var time: String = ""
    @State public var totalPill: String = ""
    @State public var remainingPill: String = ""
    @State public var date: Date = Date()
    @State public var daysOfTheWeek:[String] = []
    @State private var isDayofTheWeekBottomSheetShowing: Bool = false
    @State public var endDate: Date = Date()
    @State public var isMedTaken: Bool = false
    @EnvironmentObject var medsViewModel: MedsViewModel
    
    var body: some View {
        NavigationStack{
           
            ZStack{
                backgroundColor.ignoresSafeArea()
                VStack{
                    Spacer()
                        .toolbar{
                            ToolbarItem(placement: .navigationBarLeading) {
                                AddMedsBackButton()
                            }
                        }
                        .navigationTitle("Add Medications")
                 
                        ZStack{
                            RoundedRectangle(cornerRadius: 10).foregroundColor(.white).frame(width:350, height: 250)
                            VStack{
                                Spacer()
                                HStack{
                                    Text("Medicine Details")
                                        .font(.title2)
                                        .bold()
                                        .padding(.leading, 30)
                                    Spacer()
                                }
                                .offset(y: -30)
                               Spacer()
                                HStack{
                                    Text("Medicine Name")
                                        .font(.title3)
                                        .padding(.leading, 30)
                                    Spacer()
                                }
                                .offset(y: -80)
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray).opacity(0.1)
                                        .frame(width:325, height: 40)
                                    TextField("Name", text: $name)
                                        .padding(.leading)
                                        .foregroundColor(.primary)
                                        .offset(x:15)
                                                                                
                                }
                                .offset(y: -80)
                              
                                
                                HStack{
                                    Text("Dosage")
                                        .font(.title3)
                                        .padding(.leading, 30)
                                    Spacer()
                                }
                                .offset(y: -80)
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray).opacity(0.1)
                                        .frame(width:325, height: 40)
                                    TextField("Dosage", text: $dosage)
                                        .padding(.leading)
                                        .foregroundColor(.primary)
                                        .offset(x:15)
                                }
                                .offset(y: -80)
                            }
                            
                        }
                        
                        .offset(y: -40)
                    Spacer()
                 
                   
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.white).frame(width:350, height: 250)
                        VStack{
                            HStack{
                                Text("Time & Schedule")
                                    .font(.system(size: 24))
                                    .bold()
                                    .padding(.leading,30)
                                          
                                Spacer()
                            }
                            .offset(y: -30)
                            
                            HStack{
                                
                                Text("Time")
                                    .font(.system(size: 20))
                                    .padding(.leading, 30)
                            Spacer()
                                Text( "End Date")
                                    .font(.system(size: 20))
                                    .padding(.trailing, 30 )
                            
                            }
                            .offset(y: -20)
                            HStack{
                                DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .padding(.leading, 25)
                                
                                Spacer()
                                
                                    DatePicker("", selection: $endDate, displayedComponents: [.date])
                                        .datePickerStyle(.compact)
                                        .labelsHidden()
                                        .padding( .trailing, 25)
                               
                            }
                            .offset( y: -20)
                            
                            HStack{
                                Text("Repeat")
                                    .font(.system(size: 20))
                                    .padding(.leading, 30)
                                
                                Spacer()
                                
                            }
                            HStack{
                                
                                Button(action: {
                                    isDayofTheWeekBottomSheetShowing.toggle()
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 100, height: 40)
                                            .foregroundColor(.secondary)
                                            .opacity(0.1)
                                            .padding(.leading, 25)
                                        
                                        Text("Days")
                                            .font(.system(size: 18))
                                            .foregroundColor(.primary)
                                        
                                    }
                                })
                                .sheet(isPresented: $isDayofTheWeekBottomSheetShowing) {
                                    dayOfTheWeekBottomSheet()
                                        .presentationDetents([.medium, .large])
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .offset(y: -40)
                    
                    
                    
                    
                   
                    
                    Button {
                        let (condition1, condition2) = isTextAppropriate()
                        if condition1 && condition2 {
                            saveButtonPressed()
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.blue)
                                .frame(width:300, height: 50)
                            Text("Save Medicine")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                               
                        }
                    }
                    
                }
               // .ignoresSafeArea(.keyboard)
                
                .navigationDestination(isPresented: $isSaveButtonHit) {
                    HomeView()
                    .navigationBarBackButtonHidden(true)}
            }
            
        }
    }
    func saveButtonPressed(){
        medsViewModel.addMeds(name: name , Dosage: dosage, pillDate: date, totalPills: totalPill, remainingPill: remainingPill, daysOfTheWeek: medsViewModel.daysOfTheWeek, endDate: endDate, isMedTaken: isMedTaken)
        isSaveButtonHit = true
        
       // let newMedicine:medicineModel = medsViewModel.medsArray[medsViewModel.medsArray.count - 1]
        
        //Notifications().scheduleNotification(medicine: newMedicine)
        medsViewModel.daysOfTheWeek.removeAll()
        
    }
    
    func isTextAppropriate() -> (Bool,Bool){
        var nameCount = true
        var dosageCount = true
        if name.count < 2{
            nameCount = false
        }
        if dosage.count < 1 {
            dosageCount = false
        }
        return(nameCount, dosageCount)
    }
}



struct AddMedsBackButton: View {
    @State private var isButtonHit: Bool = false
    
    
    var body: some View {
        NavigationStack{
            
            
            Button {
                isButtonHit = true
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.primary)
                    .font(.system(size: 16))
                    .bold()
            }
            
            
        }
        .navigationDestination(isPresented: $isButtonHit) {
            HomeView()
                .navigationBarBackButtonHidden(true)
        }
    }
  
}

struct dayOfTheWeekBottomSheet: View{
    @EnvironmentObject var medsViewModel: MedsViewModel
    
    @State private var buttons:Array = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday","Every Day of the Week"]
    
    
    
    @State private var showMondayCheckMark:Bool = false
    @State private var showTuesdayCheckMark:Bool = false
    @State private var showWednesdayCheckMark:Bool = false
    @State private var showThursdayCheckMark:Bool = false
    @State private var showFridayCheckMark:Bool = false
    @State private var showSaturdayCheckMark:Bool = false
    @State private var showSundayCheckMark:Bool = false
    @State private var showEveryDayCheckmark:Bool = false

    var body: some View {
        NavigationStack{
            List{
                    Button {
                        showMondayCheckMark.toggle()
                        medsViewModel.daysOfTheWeek.append("Monday")
                    } label: {
                            HStack{
                                Text("Monday")
                                Spacer()
                                if showMondayCheckMark || showEveryDayCheckmark{
                                    Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                    
                                }
                            }
                    }
                Button {
                    showTuesdayCheckMark.toggle()
                    medsViewModel.daysOfTheWeek.append("Tuesday")
                } label: {
                        HStack{
                            Text("Tuesday")
                            Spacer()
                            if showTuesdayCheckMark || showEveryDayCheckmark{
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                }
                Button {
                    showWednesdayCheckMark.toggle()
                    medsViewModel.daysOfTheWeek.append("Wednesday")
                    
                } label: {
                        HStack{
                            Text("Wednesday")
                            Spacer()
                            if showWednesdayCheckMark || showEveryDayCheckmark{
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                }
                Button {
                    showThursdayCheckMark.toggle()
                    medsViewModel.daysOfTheWeek.append("Thursday")
                } label: {
                        HStack{
                            Text("Thursday")
                            Spacer()
                            if showThursdayCheckMark || showEveryDayCheckmark{
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                }
                Button {
                    showFridayCheckMark.toggle()
                    medsViewModel.daysOfTheWeek.append("Friday")
                } label: {
                        HStack{
                            Text("Friday")
                            Spacer()
                            if showFridayCheckMark || showEveryDayCheckmark{
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                }
                Button {
                    showSaturdayCheckMark.toggle()
                    medsViewModel.daysOfTheWeek.append("Saturday")
                    
                } label: {
                        HStack{
                            Text("Saturday")
                            Spacer()
                            if showSaturdayCheckMark || showEveryDayCheckmark{
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                }
                Button {
                    showSundayCheckMark.toggle()
                    medsViewModel.daysOfTheWeek.append("Sunday")
                    
                } label: {
                        HStack{
                            Text("Sunday")
                            Spacer()
                            if showSundayCheckMark || showEveryDayCheckmark{
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                }
                Button {
                    showEveryDayCheckmark.toggle()
                } label: {
                        HStack{
                            Text("Every day of the Week")
                            Spacer()
                            if showEveryDayCheckmark{
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                }
                }
               
                
            }
            
            
        }
    }
    
















struct AddMeds_View_Previews: PreviewProvider {
    static var previews: some View {
        AddMeds_View()
    }
}
