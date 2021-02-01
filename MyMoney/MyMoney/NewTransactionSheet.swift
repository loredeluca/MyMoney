//
//  NewTransactionSheet.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 29/01/2021.
//

import SwiftUI

extension ContentView {
    
    struct NewTransactionSheet: View {
        @ObservedObject var c: Controls
        @ObservedObject var w1: Wallet1_Obs

        @State var showingDetail = false
        
        //sheet
        @State var selectedIndex = 0
        var titles = ["Entrate", "Uscite"]
        
        @State var name: String = ""
        
        @State var selectedDate = Date()
        
        @State var amount = ""
        
        @State var selectedEntryIndex = 0
        var categoryEntry = ["Stipendio", "Crediti", "Rimborsi", "Regali"]
        
        @State var selectedExitIndex = 0
        var categoryExit = ["Casa", "Cibo", "Automobile", "Vacanze", "Altro"]
        
        @State var note = ""
        

        var body: some View {
            Button(action: {
                self.showingDetail.toggle()
            }) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 25.0, height: 25.0)
                    .foregroundColor(c.e1() ? .blue : .white)
                //Text("Show Detail")
            }
            .disabled(!c.e1())
            .sheet(isPresented: $showingDetail) {
                NavigationView {
                    Form {
                        VStack{
                            Picker(selection: self.$selectedIndex, label: Text("Entrate o Uscite?")) {
                                ForEach(0..<titles.count) { index in
                                    Text(titles[index]).tag(index)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                            Spacer().frame(height: 30)
                            Divider()
                            
                            Spacer().frame(height: 15)
                            TextField("Nome", text: $name)
                            //Spacer().frame(height: 10)
                            Divider()

                            DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: [.date/*, .hourAndMinute*/]) {
                                Text("Data")
                            }
                            .accentColor(.black)
                            //.frame(width: 100, alignment: .trailing)//.center)
                            
                            VStack{
                                Divider()
                                Spacer().frame(height: 15)
                                HStack{
                                    TextField("Importo", text: $amount)
                                    Text("€")
                                }
                                Divider()
                            }
                            VStack{
                                //Spacer().frame(height: 0)
                                if self.selectedIndex == 0{
                                    Section {
                                        Picker(selection: $selectedEntryIndex, label: Text("Categoria").frame(width: 80, height: 0, alignment: .trailing)) {
                                            ForEach(0 ..< categoryEntry.count) {
                                                Text(self.categoryEntry[$0])
                                            }
                                        }.frame(width: 360, height: 100, alignment: .center)
                                    }.frame(width: 310, height: 35, alignment: .center)
                                }
                                else{
                                    Section {
                                        Picker(selection: $selectedExitIndex, label: Text("Categoria").frame(width: 80, height: 0, alignment: .trailing)) {
                                            ForEach(0 ..< categoryExit.count) {
                                                Text(self.categoryExit[$0])
                                            }
                                        }.frame(width: 360, height: 100, alignment: .center)
                                    }.frame(width: 310, height: 35, alignment: .center)
                                }
                                Divider()
                                
                                Spacer().frame(height: 15)
                                TextField("Note", text: $note)
                                Spacer().frame(height: 100)
                                //Divider()
                            }
                        }//End Primo VStack sheet
                        //TextField("Username", text: $username)
                    }
                    .navigationBarItems(
                        leading:
                            Button(action: {
                                self.showingDetail.toggle()
                                amount = ""
                                name = ""
                                note = ""
                            }){
                                Text("Annulla")
                                    .fontWeight(.regular)
                            },
                        trailing:
                            Button(action: {
                                print("Button pressed...")
                                if amount != ""{
                                    if self.selectedIndex == 0{
                                        w1.addImage(value: "chevron.up.circle.fill")
                                        w1.addCategory(value: categoryEntry[selectedEntryIndex])
                                        w1.addName(value: name)
                                        w1.addDate(value: selectedDate)
                                        w1.addOperation(value: "+ € " + amount)
                                        w1.addINOp(value: Float(amount)!)
                                        w1.add(value: Float(amount) ?? 0)
                                        //c.updateCardTotBal(value: 0, op: Int(amount) ?? 0)
                                    }
                                    else{
                                        w1.addImage(value: "chevron.down.circle.fill")
                                        w1.addCategory(value: categoryExit[selectedExitIndex])
                                        w1.addName(value: name)
                                        w1.addDate(value: selectedDate)
                                        w1.addOperation(value: "- € " + amount)
                                        w1.addOUTOp(value: Float(amount)!)
                                        w1.remove(value: Float(amount) ?? 0)
                                        c.updateBudget(value: Float(amount) ?? 0)
                                        //c.updateCardTotBal(value: 0, op: Int(amount) ?? 0)
                                        //mywallet.reduceBudget(value: Int(amount) ?? 0)
                                        //mywallet.reduceCircle()
                                        //print(mywallet.budget)
                                    }
                                }
                                amount = ""
                                name = ""
                                note = ""
                                //controllo se Budget è da resettare
                                if !w1.getMonth(value: selectedDate){
                                    c.resetCircleBudget()
                                }
                                self.showingDetail.toggle()
                            }){
                                Text("Aggiungi")
                            })
                    .navigationBarTitle("Nuovo movimento", displayMode: .inline)
                }
            }
        }
    }
}
