//
//  Utils.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

extension ContentView {
    
    struct AddAvailableBalance: View {
        @State var ab: String = ""
        @ObservedObject var w1: Wallet1_Obs
        @Binding var setAvailableBalance: Bool
        
            
        
        var body: some View{
            ZStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .shadow(radius: 5.0)
                        .foregroundColor(.white)
                        .frame(width: 270, height: 165)
                        .transition(.slide)
                    VStack{
                        Text("Saldo disponibile")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0)
                        Text("Inserisci l'attuale saldo disponibile")
                            .font(.system(size: 14))
                            .fontWeight(.regular)//bold)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 5)
                        Text("nel tuo conto")
                            .font(.system(size: 14))
                            .fontWeight(.regular)//bold)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 5)
                        TextField("Saldo disponibile", text: $ab)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 15))
                            .frame(maxWidth: 250, alignment: .center)
                            .offset(x: 0, y: 0)
                        Divider()
                        Button(action: {
                            if ab != ""{
                                w1.setAvailableBalance(value: Float(ab)!)
                            }
                            setAvailableBalance.toggle()
                        }, label: {
                            Text("OK")
                                .frame(maxWidth: 250, alignment: .center)
                                .offset(x: 0, y: 5)
                        })
                    }
                }.offset(x: 0, y: -350)
                
            }
        }
    }
    
    struct AddBugdet: View {
        @State var b: String = ""
        @ObservedObject var c: Controls
        @Binding var setBudget: Bool
        
            
        
        var body: some View{
            ZStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .shadow(radius: 5.0)
                        .foregroundColor(.white)
                        .frame(width: 270, height: 155)
                        .transition(.slide)
                    VStack{
                        Text("Budget Mensile")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0)
                        Text("Inserisci nuovo budget mensile")
                            .font(.system(size: 14))
                            .fontWeight(.regular)//bold)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 5)
                        TextField("Budget", text: $b)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 15))
                            .frame(maxWidth: 250, alignment: .center)
                            .offset(x: 0, y: 0)
                        Divider()
                        Button(action: {
                            if b != ""{
                                c.setBudget(value: Float(b)!)
                            }
                            setBudget.toggle()
                        }, label: {
                            Text("OK")
                                .frame(maxWidth: 250, alignment: .center)
                                .offset(x: 0, y: 5)
                        })
                    }
                }.offset(x: 0, y: -350)
                
            }
        }
    }
    
    
    struct Confirm: View {
        @Binding var confirm: Bool
            
        
        var body: some View{
            ZStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .shadow(radius: 5.0)
                        .foregroundColor(.white)
                        .frame(width: 270, height: 135)
                        .transition(.slide)
                    VStack{
                        Text("Elimina Carta?")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 30)
                        Text("Rimuovendo la carta, eliminerai")
                            .font(.system(size: 14))
                            .fontWeight(.regular)//bold)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 35)
                        Text("tutti i dati")
                            .font(.system(size: 14))
                            .fontWeight(.regular)//bold)
                            .frame(maxWidth: 300, alignment: .center)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 35)
                        Spacer().frame(height: 45)
                        Divider()
                        HStack{
                            Button(action: {
                                confirm.toggle()
                            }, label: {
                                Text("Annulla")
                                    .frame(height: 20, alignment: .center)
                                    .offset(x: -30, y: -8)
                            })
                            Divider()
                                .offset(x: 0,y: -8)
                            Button(action: {
                                //Elimina qualcosa
                                confirm.toggle()
                            }, label: {
                                Text("Elimina")
                                    .frame(height: 10, alignment: .center)
                                    .foregroundColor(.red)
                                    .offset(x: 30, y: -8)
                            })
                        }
                    }
                }.offset(x: 0, y: -350)
                
            }
        }
    }
 }
