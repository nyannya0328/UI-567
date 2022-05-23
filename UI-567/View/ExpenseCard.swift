//
//  ExpenseCard.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI

struct ExpenseCard: View {
    
 
    var expense : FetchedResults<Expense>
    @EnvironmentObject var model : ExpenceViewModel
    
    var isDetai : Bool = false
    var body: some View {
        GeometryReader{proxy in
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                
                    LinearGradient(colors: [
                    
                    Color("Gradient1"),
                    Color("Gradient2"),
                    Color("Gradient3"),
                    
                    
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                
                )
            
            
            VStack(spacing:15){
                
                
                VStack(spacing:15){
                    
                    Text(isDetai ? model.converDateToString() : model.currentMonthString())
                        .font(.callout.weight(.bold))
                    
                    
                    Text(model.convertExpencesToPrice(expences: expense))
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom,5)
                    
                }
                .offset(x: -10)
                
                
                HStack(spacing:10){
                    
                    
                    Image(systemName: "arrow.down")
                        .font(.caption.bold())
                        .foregroundColor(Color("Green"))
                        .frame(width: 30, height: 30)
                        .background(.white,in: Circle())
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        
                        Text("Income")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(model.convertExpencesToPrice(expences: expense,type: "Income"))
                            .font(.callout.weight(.semibold))
                            .lineLimit(1)
                            .fixedSize()
                        
                    }
                   .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(Color("Green"))
                        .frame(width: 30, height: 30)
                        .background(.white,in: Circle())
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        
                        Text("Expenses")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(model.convertExpencesToPrice(expences: expense,type: "Expenses"))
                            .font(.callout.weight(.semibold))
                            .lineLimit(1)
                            .fixedSize()
                        
                    }
                    .padding(.trailing)
                    
                    
                    
                    
                }
                .padding(.horizontal)
                .offset(y: 15)
                
                
                
               
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
         //   .animation(.none, value: )
             
            
            
            
            
        }
        .frame(height: 250)
        .padding(.top)
    }
}

struct ExpenseCard_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
