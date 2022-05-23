//
//  StaticsGraphView.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI

struct StaticsGraphView: View {
    
    @EnvironmentObject var model : ExpenceViewModel
    @Environment(\.self) var env
    @State var staticisGraph : [StaticksGraph] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            
            VStack{
                
                HStack(spacing:15){
                    
                    Button {
                        env.dismiss()
                    } label: {
                        
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(Color("Gray"))
                            .frame(width: 40, height: 40)
                            .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    
                    Text("Statistics")
                        .font(.title.weight(.bold))
                        .lineLimit(1)
                        .opacity(0.7)
                          .frame(maxWidth: .infinity,alignment: .leading)

                    
                }
                
                
                DynamicFileterView(startDate: Date(), endDate: Date(), type: "NONE") { (expence : FetchedResults<Expense>) in
                    
                    
                    VStack(spacing:15){
                        
                        ForEach(staticisGraph){graph in
                            
                            GroupCardView(graph: graph)
                            
                        }
                        
                    }
                    .padding(.top)
                    .onAppear {
                        
                    }
                }
                
                
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background{
            
            
            Color("BG").ignoresSafeArea()
            
        }
       
    }
    @ViewBuilder
    func GroupCardView(graph : StaticksGraph)->some View{
        
        VStack(alignment: .leading, spacing: 12) {
            
            
            Text(graph.monthString)
                .font(.callout.weight(.semibold))
                .opacity(0.7)
            
            
            
            
            
            
        }
        
    }
}

struct StaticsGraphView_Previews: PreviewProvider {
    static var previews: some View {
        StaticsGraphView()
    }
}
