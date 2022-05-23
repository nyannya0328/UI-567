//
//  Home.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI

struct Home: View {
    @StateObject var model : ExpenceViewModel = .init()
    
    @AppStorage("User_Name") var userName : String = ""
    
    @EnvironmentObject var lockModel : LockViewModel
    
    @AppStorage("lock_Content") var lockContent : Bool = false
    
    @Environment(\.self) var env
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:15){
                HStack(spacing:15){
                    
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        
                        Text("Welcome")
                            .font(.callout.weight(.semibold))
                            .foregroundColor(.gray)
                        
                        
                        Text(userName)
                            .font(.title2.bold())
                            .lineLimit(1)
                            .onTapGesture {
                                
                                model.askUserName()
                            }
                        
                            
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    
                    if lockModel.isAvailable{
                        
                        Button {
                            
                            lockContent.toggle()
                            
                            if lockContent{
                                
                                lockModel.authenTicationUser()
                            }
                            
                        } label: {
                            
                            Image(systemName: !lockContent ? "lock.open" : "lock")
                                .foregroundColor(Color("Gray"))
                                .frame(width: 40, height: 40)
                                .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        }
                    }
                    
                    
                   

                    
                    
                    
                    NavigationLink {
                        
                        StaticsGraphView()
                            .environmentObject(model)
                        
                    } label: {
                        
                        
                        Image(systemName: "chart.bar.xaxis")
                            .foregroundColor(Color("Gray"))
                            .frame(width: 40, height: 40)
                            .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }

                    
                    NavigationLink {
                        
                    } label: {
                        
                        
                        Image(systemName: "circle.hexagongrid.circle")
                            .foregroundColor(Color("Gray"))
                            .frame(width: 40, height: 40)
                            .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        
                        
                        
                    }



                    
                    
                }
                
                DynamicFileterView(startDate: model.startDate, endDate: model.endDate, type: "ALL") { (expnese : FetchedResults<Expense>) in
                    
                    ExpenseCard(expense: expnese)
                        .environmentObject(model)
                    
                    
                    Transactions(expences: expnese)
                        .environmentObject(model)
                    
                }
                
               
                
            }
            
        }
        .padding()
        .background{
            
            
         Color("BG")
                .ignoresSafeArea()
            
        }
        
        .overlay(alignment: .bottomTrailing) {
            
            
            AddButton()
                .padding()
            
            
        }
        
        .overlay {
            if model.addNewExpense{
                
                
                addNewExpenceView()
                    .transition(.move(edge: .bottom))
                
            }
        }
       
        
    }
    @ViewBuilder
    func addNewExpenceView()->some View{
        
        VStack{
            
            VStack(spacing:15){
                
                Text("Add New Expence")
                
                if let symbol = model.convertNumberToPrice(value: 0).first{
                    
                    HStack(spacing: 5){
                        
                        TextField("0", text: $model.amount)
                            .font(.system(size: 35))
                            .foregroundColor(Color("Gradient2"))
                            .multilineTextAlignment(.center)
                            .textSelection(.disabled)
                            .keyboardType(.numberPad)
                            .background{
                                
                             
                                Text(model.amount == "" ? "0" : model.amount)
                                    .font(.system(size: 35))
                                    .opacity(0)
                                    .overlay(alignment:.leading) {
                                        Text(String(symbol))
                                            .opacity(0.5)
                                            .offset(x: -15, y: 5)
                                            
                                    }
                                
                                
                            }
                        
                        
                    }
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .background(Capsule().fill(.white))
                    .padding(.horizontal,20)
                    .padding(.top,20)
                    
                }
                
                Label {
                    TextField("Remark", text: $model.remark)
                        .padding(.leading,15)
                } icon: {
                    
                    Image(systemName: "list.bullet.rectangle.portrait")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .frame(maxWidth: .infinity,alignment: .center)
                .background{
                    
                    
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                    
                    
                }
                .padding(.top,20)
                
                Label {
                    
                    CheckBox()
                } icon: {
                    
                    Image(systemName: "arrow.up.arrow.down")
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .frame(maxWidth: .infinity,alignment: .center)
                .background{
                    
                    
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                    
                    
                }
                .padding(.top,5)
                
                Label {
                    
                    DatePicker("", selection: $model.expenseDate,displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding(.leading,10)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                } icon: {
                    
                    
                    Image(systemName: "calendar")
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .frame(maxWidth: .infinity,alignment: .center)
                .background{
                    
                    
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                    
                    
                }
                .padding(.top,5)
                
                
                Button {
                    
                    model.addExpense(env: env)
                } label: {
                    
                    
                    Text("SAVE")
                        .font(.title3.bold())
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity,alignment: .center)
                        .foregroundColor(.white)
                        .background{
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                
                                    LinearGradient(colors: [
                                    
                                    Color("Gradient1"),
                                    Color("Gradient2"),
                                    Color("Gradient3"),
                                    
                                    
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                
                                )
                            
                         
                            
                            
                        }
                      .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottom)
                }




                
            }
              .frame(maxHeight: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            
            
            Color("BG").ignoresSafeArea()
            
        }
        .overlay(alignment: .topTrailing) {
            
            
            Button {
                model.addNewExpense = false
                model.reset()
            } label: {
                
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.black.opacity(0.5))
                
                
            }
            .padding()

        }
     
        
    }
    @ViewBuilder
    func CheckBox()->some View{
        
        HStack(spacing:15){
            
            ForEach(["Income","Expenses"],id:\.self){type in
                
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black,lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .opacity(0.5)
                    
                    
                    if model.type == type{
                        
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("Green"))
                    }
                        
                    
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    
                    
                    model.type = type
                }
                
                Text(type)
                    .font(.callout.weight(.semibold))
                    .opacity(0.6)
                    .padding(.trailing,10)
                
            }
        }
          .frame(maxWidth: .infinity,alignment: .leading)
          .padding(.leading,20)
        
        
    }
    @ViewBuilder
    func AddButton() -> some View{
        
        Button {
            
            model.addNewExpense.toggle()
            
        } label: {
            
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .padding(12)
                .background{
                    
                 
                    Circle()
                        .fill(
                        
                            LinearGradient(colors: [
                            
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3"),
                            
                            
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        
                        
                        
                        )
                    
                    
                    
                }
                .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 0)
                .padding(.trailing)
        }

        
        
    }
    @ViewBuilder
    func Transactions(expences : FetchedResults<Expense>)->some View{
        
        
        VStack{
            
            Text("Transactions")
                .font(.title2.bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
            ForEach(expences){expence in
                
                
                TransactionCardView(expense: expence)
            }
            
            
            
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
