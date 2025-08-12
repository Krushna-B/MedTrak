//
//  GetStarted.swift
//  Medicine Tracker
//
//  Created by admin on 6/29/23.
//

import SwiftUI

struct GetStarted: View {
    
    let backgroundColor = Color(red: 242/255, green: 242/255, blue: 247/255)
    let arrowColor = Color( red: 122/255, green: 123/255, blue: 233/255)
    let circleColor = Color( red:85/255, green: 83/255, blue: 212/255)
    var Title:String = "Personal Information"
    var info:String = "Enter your personal information to help create your own personal account"
    @AppStorage("FirstName") public var firstName: String = ""
    @AppStorage("LastName") public var lastName: String = ""
    @AppStorage("Email") public var email: String = ""
    @State  public var birthday = Date()
    @State private var isHomeViewActive: Bool = false
    @State private var isBackButtonHit: Bool = false
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                backgroundColor.ignoresSafeArea()
                VStack{
                    
                    Spacer()
                    
                    Text(Title).foregroundColor(Color.black).font(.largeTitle).bold().padding(.trailing, 15).padding(.bottom, 2).offset(y: -25)
                    Text(info).foregroundColor(Color.black).multilineTextAlignment(.leading).padding(.leading,18).font(.system(size:16, weight: .regular, design: .default)).offset(y: -25)
                    
                    Spacer()
                    Form {
                        
                        TextField("First Name", text:$firstName)
                            .font(.system(size:16))
                            .frame(height: 65)
                        
                        TextField("Last Name", text:$lastName)
                            .font(.system(size:16))
                            .frame(height: 65)
                        
                        TextField("Email Address", text:$email)
                            .font(.system(size:16))
                            .frame(height: 65)
                        DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                            .font(.system(size:16))
                            .frame(height: 65)
                        
                    }
                    
                    .accentColor(Color.black)
                    
                    .frame(width:370 , height: 400)
                    Spacer()
                    Button {
                        isHomeViewActive = true
                    }
                label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).foregroundColor(Color.blue).frame(width:320, height: 50).padding(.bottom, 20)
                        HStack{
                            
                            Text("Continue").foregroundColor(Color.white).padding(.bottom,20)
                                .alignmentGuide(HorizontalAlignment.center){$0[HorizontalAlignment.center] }
                                .alignmentGuide(VerticalAlignment.center){$0[VerticalAlignment.center] }
                                .font(.system(size:20))
                                .offset(x:17)
                            
                            ZStack{
                                Circle().foregroundColor(circleColor)
                                    .frame(width:35, height: 35)
                                    .padding(.bottom, 20)
                                
                                Image(systemName: "arrow.right")
                                    .foregroundColor(arrowColor)
                                    .font(.system(size: 20))
                                    .padding(.bottom, 20)
                                
                            }
                            .offset(x:75)
                        }
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
                
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isHomeViewActive = true
                        } label: {
                            Text("Skip").foregroundColor(.black).bold()
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            isBackButtonHit = true
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                                .font(Font.system(size:20, weight: .regular)).bold()
                        }

                    }
                }
                    
                    
                }
                
                
                .navigationDestination(isPresented: $isHomeViewActive) {
                    HomeView()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationDestination(isPresented: $isBackButtonHit) {
                    StartView()
                        .navigationBarBackButtonHidden(true)
                }
                
            }
        }
        
        
    }
    
}
    
struct GetStarted_Previews: PreviewProvider {
    static var previews: some View {
        GetStarted()
    }
}




