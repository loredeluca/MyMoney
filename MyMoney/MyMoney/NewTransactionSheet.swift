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
        @ObservedObject var w: Wallet_Obs

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
                    .foregroundColor(c.e1() || c.e2() || c.e3() ? .blue : .white)
            }
            .disabled(!c.e1() && !c.e2() && !c.e3())
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
                                        w.addImage(value: "chevron.up.circle.fill")
                                        w.addCategory(value: categoryEntry[selectedEntryIndex])
                                        w.addName(value: name)
                                        w.addDate(value: selectedDate)
                                        w.addOperation(value: "+ € " + amount)
                                        w.addINOp(value: Float(amount)!)
                                        w.add(value: Float(amount) ?? 0)                                    }
                                    else{
                                        w.addImage(value: "chevron.down.circle.fill")
                                        w.addCategory(value: categoryExit[selectedExitIndex])
                                        w.addName(value: name)
                                        w.addDate(value: selectedDate)
                                        w.addOperation(value: "- € " + amount)
                                        w.addOUTOp(value: Float(amount)!)
                                        w.remove(value: Float(amount) ?? 0)
                                        c.updateBudget(value: Float(amount) ?? 0)
                                    }
                                }
                                amount = ""
                                name = ""
                                note = ""
                                //Check budget
                                if !w.getMonth(value: selectedDate){
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
