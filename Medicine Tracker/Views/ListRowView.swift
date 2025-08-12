//
//  ListRowView.swift
//  Medicine Tracker
//
//  Created by admin on 7/2/23.
//

import SwiftUI

struct ListRowView: View {
    @EnvironmentObject var medsViewModel: MedsViewModel
    
    let meds: medicineModel
    
    var body: some View {
        NavigationStack{
            
            
            Button {
                //
            } label: {
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                        Text(meds.title)
                            .foregroundColor(.primary)
                            .font(.system(size:24, weight: .medium))
                            .padding(.bottom)
                        Spacer()
                    }
                        HStack{
                            Text(meds.Doasage)
                                .font(.system(size: 14))
                                .foregroundColor(.primary)
                                Spacer()
                            ForEach(meds.daysOfTheWeek, id: \.self){ index in
                                  Text(index.prefix(3))
                                        .font(.system(size: 10))
                                        
                                        .foregroundColor(.primary)
                            }
                            
                        }
                        
                    }
                    Text(getMedicineDate())
                        .foregroundColor(.primary)
                        .font(.system(size: 18))
                        .offset(y:0)
                  
                    //                    Button {
                    //                        //
                    //                    } label: {
                    //                        Rectangle()
                    //                            .frame(width: 10 , height: 10)
                    //                    }
                    //
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(5)
            }
            
            
        }
    }
    func getMedicineDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: meds.pillDate)
    }
}


//struct ListRowView_Previews: PreviewProvider {
  //  static var previews: some View {
    //    ListRowView(meds: medicineModel)
    //}
//}
