//
//  LockViewModel.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI
import LocalAuthentication

class LockViewModel: ObservableObject {
    
    @Published var isUnlocked : Bool = false
    @Published var isAvailable : Bool = false
    
    
    func authenTicationUser(){
        
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error:nil){
            
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Security to Hide") { status, _ in
                
                
                DispatchQueue.main.async {
                    
                    self.isUnlocked = status
                    
                }
            }
            
        }
        
        else{
            
            isUnlocked = false
            isAvailable = false
        }
        
    }
}
