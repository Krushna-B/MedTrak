//
//  StartView.swift
//  Medicine Tracker
//
//  Created by admin on 6/29/23.
//

import SwiftUI

struct StartView: View {
    var AppBackgroundColor = Color(red: 0.2, green: 0.4, blue: 0.6)
    @State var isGetStartedActive: Bool = false
    @State private var GetStartedImage:Image = Image("Image")
    @State private var Title = "Let's Get Started"
    @State private var textInfo = "Track your daily medicine usage and set reminders for yourself with ease"
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.white
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                VStack() {
                    Spacer()
                    GetStartedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:350, height: 350)
                        .offset(y: -100)
                    
                    
                    Text(Title).bold().font(.largeTitle).foregroundColor(Color.black).padding(.bottom,7)
                        .offset(y: -125).font(.system(size:45 ))
                    
                    Text(textInfo).font(.system(size:15, weight: .regular, design: .default)).multilineTextAlignment(TextAlignment.center)
                        .offset(y: -125)
                    
                    Spacer()
                    
                    Button {
                        self.isGetStartedActive = true
                    }
                label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).foregroundColor(Color.blue).frame(width:300, height: 50).padding(.bottom, 20)
                        Text("Get Started").foregroundColor(Color.white).padding(.bottom,20)
                        }
                    }
                .navigationDestination(isPresented: $isGetStartedActive) {
                    GetStarted()
                    
                        
                }
                       
                }
            }
        }
    }
}
                        
                    
                    
                    
                    
                
                
          


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
