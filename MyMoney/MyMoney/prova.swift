//
//  prova.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

/*
 Button(action: {
     self.showingDetail.toggle()
 }){
     Text("Annulla")
         .fontWeight(.regular)
 }
 .offset(x:-165, y: -350)
 */

import SwiftUI

extension ContentView {
    
    struct PROVA: View {
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
                    .frame(width: 15.0, height: 15.0)
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
                                        w1.add(value: Int(amount) ?? 0)
                                        //c.updateCardTotBal(value: 0, op: Int(amount) ?? 0)
                                    }
                                    else{
                                        w1.addImage(value: "chevron.down.circle.fill")
                                        w1.addCategory(value: categoryExit[selectedExitIndex])
                                        w1.addName(value: name)
                                        w1.addDate(value: selectedDate)
                                        w1.addOperation(value: "- € " + amount)
                                        w1.remove(value: Int(amount) ?? 0)
                                        //c.updateCardTotBal(value: 0, op: Int(amount) ?? 0)
                                        //mywallet.reduceBudget(value: Int(amount) ?? 0)
                                        //mywallet.reduceCircle()
                                        //print(mywallet.budget)
                                    }
                                }
                                amount = ""
                                name = ""
                                note = ""
                                self.showingDetail.toggle()
                            }){
                                Text("Aggiungi")
                            })
                    .navigationBarTitle("Nuovo movimento", displayMode: .inline)
                }
            }
        }
    }

    struct PLUS:View {
        @ObservedObject var controlli: Controls
        @ObservedObject var mywallet: Wallet1_Obs
        
        @State var showSheetView = false
        //@Binding var showSheetView: Bool
        
        //sheet addTransaction
        
        @State var isShowSheet1 = false
        
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
        
        var body: some View{
            Button(action: {
                self.showSheetView.toggle()
            }){
                Image(systemName: "plus.circle")
                    .font(.system(size: 25))
            }.sheet(isPresented: $showSheetView){
                //SheetView(showSheetView: self.$showSheetView)
                //prova(controlli: controlli ,mywallet: mywallet, showSheetView: self.$showSheetView)
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
                    }.navigationBarItems(
                        leading:
                            Button(action: {
                                print("1,\(showSheetView)")
                                showSheetView.toggle()
                                print("2,\(showSheetView)")
                                amount = ""
                                name = ""
                                note = ""
                            }){
                                Text("Annulla")
                                    .fontWeight(.regular)
                            },
                        trailing:
                            Button(action: {
                                print("Edit button pressed...")//+selectedExit.rawValue)
                                //newadd
                                if amount != ""{
                                    if self.selectedIndex == 0{
                                        mywallet.addImage(value: "chevron.up.circle.fill")
                                        mywallet.addCategory(value: categoryEntry[selectedEntryIndex])
                                        mywallet.addName(value: name)
                                        mywallet.addDate(value: selectedDate)
                                        mywallet.addOperation(value: "+ € " + amount)
                                        mywallet.add(value: Int(amount) ?? 0)
                                    }
                                    else{
                                        mywallet.addImage(value: "chevron.down.circle.fill")
                                        mywallet.addCategory(value: categoryExit[selectedExitIndex])
                                        mywallet.addName(value: name)
                                        mywallet.addDate(value: selectedDate)
                                        mywallet.addOperation(value: "- € " + amount)
                                        mywallet.remove(value: Int(amount) ?? 0)
                                        //mywallet.reduceBudget(value: Int(amount) ?? 0)
                                        //mywallet.reduceCircle()
                                        //print(mywallet.budget)
                                                    
                                    //exit
                                    //mywallet.addExitCategory(value: categoryExit[selectedExitIndex])
                                    //mywallet.addExitOperation(value: "- € " + amount)
                                    }
                                }
                                amount = ""
                                name = ""
                                note = ""
                                print("1,\(showSheetView)")
                                showSheetView.toggle()
                                print("2,\(showSheetView)")
                                showSheetView = false
                            }){
                                Text("Aggiungi, \(String(showSheetView))")
                            })
                    .navigationBarTitle("Nuovo movimento", displayMode: .inline)
                }
            }
        }
    }
}
