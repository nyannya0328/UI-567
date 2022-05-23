//
//  Extensions.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI

extension ObservableObject{
    
    func alertTF(title : String,Message : String,hintText : String,primaryTitle : String,secondaryTitle : String, primaryAction : @escaping(String)->(),secondaryAction : @escaping() ->()){
        
        
        
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)
        
        alert.addTextField { field in
            
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            
            
            if let text = alert.textFields?[0].text{
                
                primaryAction(text)
            }
            
            else{
                
                primaryAction("")
            }
            
   
        }))
        
        rootController().present(alert, animated: true,completion: nil)
    
        
    }
    
    
    
}


extension UINavigationController : UIGestureRecognizerDelegate{
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
        
        
        
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return viewControllers.count > 1
    }
}

func rootController()->UIViewController{
    
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{return .init()}
    
    guard let root = screen.windows.first?.rootViewController else{return .init()}
    
    return root
    
}
