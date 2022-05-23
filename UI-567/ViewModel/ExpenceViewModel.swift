//
//  ExpenceViewModel.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI
import CoreData

class ExpenceViewModel: ObservableObject {
    
    @AppStorage("User_Name") var userName : String = ""
    
    @Published var currentType : String = "Expenses"
    
    @Published var showFilters : Bool = false
    
    @Published var currentMonthDate : Date = Date()
    @Published var startDate : Date = Date()
    @Published var endDate : Date = Date()
    
    @Published var addNewExpense : Bool = false

    @Published var remark : String = ""
    @Published var amount : String = ""
    
    @Published var expenseDate : Date = Date()
    @Published var type : String = ""
    
    
    
    
    init() {
        let calendar = Calendar.current
        
        let todayDate = Date()
        
        let components = calendar.dateComponents([.year,.month], from: todayDate)
        
        let startOfMonth = calendar.date(from: components)
        
        
        self.currentMonthDate = startOfMonth!
        self.startDate = startOfMonth!
    }
    
    func converDateToString()->String{
        
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    func currentMonthString()->String{
        
        return currentMonthDate.formatted(date: .abbreviated, time: .omitted) +  " - "  +  Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertNumberToPrice(value : CGFloat) -> String{
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? ""
        
    }
    
    
    func convertExpencesToPrice(expences : FetchedResults<Expense>,type : String = "")->String{
        
        var value : CGFloat = 0
        
        if type == ""{
            
            
            value = expences.reduce(0.0, { partialResult, expences in
                
                return partialResult + (expences.type == "Income" ? expences.amount : -expences.amount)
                
                
            })
        }
        
        else{
            
            value = expences.reduce(0.0, { partialResult, expences in
                
                return partialResult + (expences.type == type ? expences.amount : 0)
            })
            
            
        }
        
        return convertNumberToPrice(value: value)
        
    }
    
    
    func addExpense(env : EnvironmentValues){
        
        
        let colors = ["Yellow","Purple","Red","Green"]
        
        let expense = Expense(context: env.managedObjectContext)
        
        expense.amount = (amount as NSString).doubleValue
        expense.remark = remark
        expense.type = type
        expense.date = expenseDate
        expense.color = colors.randomElement()
        
        if let _ = try? env.managedObjectContext.save(){
            
            addNewExpense = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                self.reset()
                
                
            }
        }
        
    }
    
    
    
    
    func askUserName(){
        
        
        alertTF(title: "Message", Message: "Enter Your Name", hintText: "REIWA", primaryTitle: "SAVE", secondaryTitle: "CANCEL") { value in
            
            if value != ""{self.userName = value}
            
        } secondaryAction: {
            
        }

    }
    
    
    func reset(){
        
        
        amount = ""
        remark = ""
        type = ""
        expenseDate = Date()
    }
   
}


