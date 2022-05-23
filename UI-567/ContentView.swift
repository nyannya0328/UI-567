//
//  ContentView.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var lockModel : LockViewModel = .init()
    
    @AppStorage("lock_Content") var lockContent : Bool = false
    
    @Environment(\.scenePhase) var phase
    
    var body: some View{
        
        NavigationView{
            
          Home()
                .environmentObject(lockModel)
                .navigationBarHidden(true)
        }
        .overlay {
            
            ZStack{
                
                if !lockModel.isUnlocked && lockModel.isAvailable && lockContent{
                    
                    
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            
                            lockModel.authenTicationUser()
                        }
                }
            }
        }
        .preferredColorScheme(.light)
        .onChange(of: phase) { newValue in
            
            if lockModel.isAvailable && lockContent{
                
                if newValue == .background || newValue == .inactive{
                    
                    
                    lockModel.isUnlocked = false
                }
                if newValue == .active || !lockModel.isUnlocked{
                    
                    lockModel.authenTicationUser()
                }
            }
            
        }
    }
}
 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
