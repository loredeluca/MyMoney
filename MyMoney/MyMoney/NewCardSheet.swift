//
//  NewCardSheet.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 29/01/2021.
//

import SwiftUI

struct NewCardSheet: View {
    @ObservedObject var c: Controls
    @ObservedObject var w1: Wallet1_Obs
    
    //@State var card : [String] = ["portafoglio"]
    //sheet
    @State var isShowSheet = false
    
    @State private var bgColor = Color.red

    @State var name: String = ""
    
    var circuitEntry = ["Mastercard", "Visa"]
    @State var circuitTag: Int = 0
    
    @State private var selectedDate = Date()
    
    @State private var amount = ""
    
    @State private var selectedEntryIndex = 0
    
    //popup
    @State private var showingAlert = false
    
    var body: some View {
        Button(action: {
            if c.cardCount() == 3{
                self.showingAlert = true
            }
            else{
                self.isShowSheet.toggle()
            }
        }) {
            Text("Aggiungi Carta")
                .frame(width: 120, height: 5)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.blue, lineWidth: 3))
        }
        .animation(.easeInOut)
        .offset(x:0, y: c.e1() ? 750 : (c.e2() ? 750 : (c.e3() ? 750 : 0)) )
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Attenzione!"), message: Text("Raggiunto limite di inserimento carte"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $isShowSheet){
            NavigationView {
                Form {
                    VStack{
                        //smallCard(smallCColor: bgColor , smallCName: name, smallCCircuit: circuitEntry[circuitTag])
                        
                        //SmallCard
                        ZStack{
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .shadow(radius: 5.0)
                                .foregroundColor(bgColor)
                                .frame(width: 180, height: 120)
                            Text(name)
                                .font(.system(size: 18))
                                .fontWeight(.regular)
                                .frame(maxWidth: 150, alignment: .leading)
                                .foregroundColor(.white)
                                .offset(x: -4, y: -38)
                            Image(circuitEntry[circuitTag])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 39, height: 17)
                                .offset(x: 57, y: 32)
                            ColorPicker("", selection: $bgColor)
                                .scaleEffect(x: 0.9, y: 0.9)
                                .offset(x: 160, y: -60)
                                .frame(width: 47, height: 35)
                        }
                        .frame(height: 140)
                        
                        //Title
                        VStack{
                        Text("Aggiungi carta")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer().frame(height: 10)
                        Text("Scegli nome e circuito della tua carta")
                            .fontWeight(.light)
                        }
                        Spacer().frame(height: 30)
                        Divider()
                        //Spacer().frame(height: 15)
                        
                        //Compilazione Campi
                        TextField("Nome", text: $name)
                            .font(.system(size: 18))
                        Divider()
                        
                        HStack {
                            Text("Circuito")
                            Spacer()
                            Picker("\(circuitEntry[circuitTag])", selection: $circuitTag) {
                                Text("Mastercard").tag(0)
                                Text("Visa").tag(1)
                                /*Text("Uscite")
                                    .font(.system(size: 18))
                                    .tag(2)*/
                            }
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                            .pickerStyle(MenuPickerStyle())
                        }
                        Divider()
                        
                        DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: [.date]) {
                            Text("Data")
                        }.accentColor(.black)
                        //.frame(width: 100, alignment: .trailing)//.center)
                        
                        VStack{
                            Divider()
                            Spacer().frame(height: 15)
                            HStack{
                                TextField("Importo", text: $amount)
                                    .font(.system(size: 18))
                                Text("€")
                            }
                            Divider()
                        }
                    }//VStackSheet
                }//endFormSheet
                .navigationBarItems(
                    leading:
                        Button(action: {
                            returnMainPage()
                        }){
                            HStack{
                                Image(systemName: "chevron.backward")
                                Spacer().frame(width: 1)
                                Text("Indietro").fontWeight(.regular)
                            }
                        },
                    trailing:
                        Button(action: {
                            addCard()
                        }){
                            Text("Aggiungi")
                        })
                //.navigationBarTitle("Nuovo movimento", displayMode: .inline)
            }//endNavigationViewSheet
        }//endSheet
    }
    
    //funzioni
    func addCard(){
        self.isShowSheet.toggle()
        c.app(name: name, circuit: circuitEntry[circuitTag])
        c.cardAppend(value: circuitEntry[circuitTag])
        c.setCardColor(value: c.cardCount() - 1, color: bgColor)
        //c.setCardTotBal(value: card.count-1, amount: Int(amount) ?? 0)
        c.thereiscard[c.cardCount() - 1] = true
        name = ""
        selectedEntryIndex = 0
        amount = ""
    }
    func returnMainPage(){
        self.isShowSheet.toggle()
        name = ""
        selectedEntryIndex = 0
        amount = ""
        isShowSheet = false
    }
}
