//
//  TransactionCardView.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI

struct TransactionCardView: View {
    
    var expense : Expense
    @EnvironmentObject var model : ExpenceViewModel
    @Environment(\.self) var env
    var body: some View {
        HStack(spacing:12){
            
            if let first = expense.remark?.first{
                
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color("Yellow"),in: Circle())
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
                
                
                
            }
            
            Text(expense.remark ?? "No Remark")
                .fontWeight(.semibold)
                .opacity(0.7)
                .frame(maxWidth: .infinity,alignment: .leading)
                .lineLimit(1)
            
            VStack(alignment: .trailing, spacing: 7) {
                
                let currentString = model.convertNumberToPrice(value: expense.type == "Expenses" ? -expense.amount : expense.amount)
                
                Text(currentString)
                    .font(.callout)
                    .opacity(0.7)
                    .foregroundColor(expense.type == "Expenses" ? Color("Red") : Color("Green"))
                
                Text((expense.date ?? Date()).formatted(date: .numeric, time: .omitted))
                    .opacity(0.5)
                
                
            }
        }
        .padding()
        .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .contextMenu{
            
            Button("Delete"){
                
                env.managedObjectContext.delete(expense)
                try? env.managedObjectContext.save()
            }
        }
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
