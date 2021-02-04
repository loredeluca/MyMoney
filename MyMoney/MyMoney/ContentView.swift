//
//  ContentView.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controls = Controls()
    @ObservedObject var wallet1 = Wallet_Obs()
    @ObservedObject var wallet2 = Wallet_Obs()
    @ObservedObject var wallet3 = Wallet_Obs()

    
    @State var setAvailableBalance = false
    @State var setBudget = false
    @State var confirmDelete = false

    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                    //Card1 and Objects1
                    if controls.thereiscard[0]{
                        VStack{
                            Card1(controls: controls)
                                .animation(.easeInOut)
                                .offset(x:0, y: controls.e1() ? 0 : (controls.e2() ? 750 : (controls.e3() ? 750 : 100)) )
                            InfoBlock(c: controls, w: wallet1)
                                .animation(.easeInOut)
                                .offset(x:0, y: controls.e1() ? 0 : (controls.e2() ? 750 : (controls.e3() ? 750 : 750)))
                            LastTransaction(c: controls, w: wallet1)
                                .animation(.easeInOut)
                                .offset(x:0, y: controls.e1() ? 0 : (controls.e2() ? 750 : (controls.e3() ? 750 : 750)))
                        }
                    }
                    //Card2 and Objects2
                    if controls.thereiscard[1]{
                        VStack{
                            Card2(controls: controls)
                                .animation(.easeInOut)
                                .offset(x: 0, y: controls.e2() ? 0 : (controls.e1() ? 750 : (controls.e3() ? 750 : 150)))
                            InfoBlock(c: controls, w: wallet2)
                                .animation(.easeInOut)
                                .offset(x: 0, y: controls.e2() ? 0 : (controls.e1() ? 750 : (controls.e3() ? 750 : 750)))
                            LastTransaction(c: controls, w: wallet2)
                                .animation(.easeInOut)
                                .offset(x: 0, y: controls.e2() ? 0 : (controls.e1() ? 750 : (controls.e3() ? 750 : 750)))
                        }
                    }
                    //Card2 and Objects2
                    if controls.thereiscard[2]{
                        Card3(controls: controls)
                            .animation(.easeInOut)
                            .offset(x: 0, y: controls.e3() ? -210 : (controls.e1() ? 750 : (controls.e2() ? 750 : (setBudget || setAvailableBalance ? 70: -10))))
                        InfoBlock(c: controls, w: wallet3)
                            .animation(.easeInOut)
                            .offset(x: 0, y: controls.e3() ? 20 : (controls.e1() ? 750 : (controls.e2() ? 750 : 750)))
                        LastTransaction(c: controls, w: wallet3)
                            .animation(.easeInOut)
                            .offset(x: 0, y: controls.e3() ? 460 : (controls.e1() ? 750 : (controls.e2() ? 750 : 750)))
                    }
                }
                
                //Button to add new cards
                NewCardSheet(c: controls, w: controls.cardCount() == 1 ? wallet2 : wallet3)
                    .offset(x: 0, y: setBudget || setAvailableBalance ? 105 : -50)
                    .disabled(setBudget || setAvailableBalance)
                
                //Add a new Budget
                if setBudget{
                    AddBugdet(c: controls,setBudget: $setBudget)
                }
                //Add a AvailableBalance
                if setAvailableBalance{
                    AddAvailableBalance(w: controls.e1() ? wallet1 : (controls.e2() ? wallet2 : wallet3), setAvailableBalance: $setAvailableBalance)
                }
                //Confirm card deletion
                if confirmDelete{
                    Confirm(c: controls, confirm: $confirmDelete)
                }
            }//endFirstVStack
            .navigationBarTitle("Personal Finance")
            .navigationBarItems(
                trailing:
                    NewTransactionSheet(c: controls, w: controls.e1() ? wallet1 : (controls.e2() ? wallet2 : wallet3))
            )
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Menu{
                         Section{
                            Button(action: {
                                if !setBudget{
                                    setAvailableBalance.toggle()
                                }
                                else{
                                    setBudget.toggle()
                                    setAvailableBalance.toggle()
                                }
                            }) {
                                Label("Nuovo Saldo Disponibile", systemImage: "banknote")
                                        .foregroundColor(.red)
                            }.disabled(!controls.e1() && !controls.e2() && !controls.e3())
                            Button(action: {
                                if !setAvailableBalance{
                                    setBudget.toggle()
                                }
                                else{
                                    setAvailableBalance.toggle()
                                    setBudget.toggle()
                                }
                            }) {
                                Label("Nuovo Budget", systemImage: "archivebox")
                                        .foregroundColor(.red)
                            }
                        }

                         Section(header: Text("Secondary actions")) {
                             Button(action: {
                                confirmDelete.toggle()
                             }) {
                                 Label("Elimina Carta", systemImage: "trash")
                                         .foregroundColor(.red)
                             }.disabled(!controls.e2() && !controls.e3())
                         }
                    }
                    label: {
                        Label("Add", systemImage: "ellipsis.circle") .font(.system(size: 23))
                    }
                }
            }//endToolbar
        }//endNavigationView
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
