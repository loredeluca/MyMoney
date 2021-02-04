//
//  LatestTransactions.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 29/01/2021.
//

import SwiftUI

extension ContentView{
    struct LastTransaction: View {
        @ObservedObject var c: Controls
        @ObservedObject var w: Wallet_Obs
        
        var body: some View {
            VStack{
                TitleTransaction()
                ButtonsTransaction(c: c)
                ListTransactions(c: c, w: w)
            }
        }
    }
}


struct TitleTransaction: View {
    var body: some View{
        Text("Transazioni recenti")
            .fontWeight(.bold)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .padding(.init(top: 0, leading: 0, bottom:0 , trailing: 200))
            .offset(y: 5)
        Spacer().frame(height: 10)
    }
}

struct ButtonsTransaction: View {
    @ObservedObject var c: Controls
    
    var body: some View{
        HStack{
        //bottone 1
            Button(action: {
                c.didTapAllW()
            }, label: {
            Text("Totale")
        })
        .frame(width: 70, height: 30)
        .foregroundColor(Color.black)
        .background(c.didTapW[0] ? Color.blue : Color.gray)//.opacity(0.7)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
            
        //bottone 2
            Button(action: {
                c.didTapInW()
            }, label: {
            Text("Entrate")
        })
        .frame(width: 70, height: 30)
        .foregroundColor(Color.black)
        .background(c.didTapW[1] ? Color.green : Color.gray)//.opacity(0.7)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
            
        //bottone 3
            Button(action: {
                c.didTapOutW()
            }, label: {
            Text("Uscite")
        })
        .frame(width: 70, height: 30)
        .foregroundColor(Color.black)
        .background(c.didTapW[2] ? Color.red : Color.gray)//.opacity(0.7)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
    
        }
        .frame(width: 380, alignment: .leading)
    
        Spacer().frame(height:10)
    }
}

struct ListTransactions: View{
    @ObservedObject var c: Controls
    @ObservedObject var w: Wallet_Obs
    
    var body: some View{
        ScrollView(.vertical) {
            VStack(spacing: 5) {
                if w.getCountImage()>0{ //controllo se c'è almeno un elemento
                    ForEach(w.newoperation.reversed(), id: \.self) { value in
                        //mostra Tutte le transazioni
                        if c.didTapW[0]{
                            transactionView(value: value, w: w)
                        }
                        //mostra le Entrate
                        if c.didTapW[1] && w.getImage(value: w.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill"{
                            transactionView(value: value, w: w)
                        }
                        //mostra le Uscite
                        if c.didTapW[2] && w.getImage(value: w.newoperation.firstIndex(of: value)!) == "chevron.down.circle.fill"{
                            transactionView(value: value, w: w)
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct transactionView: View{
    var value : String
    @ObservedObject var w : Wallet_Obs

    var body: some View{
        HStack{
            Image(systemName: "\(w.getImage(value: w.newoperation.firstIndex(of: value)!))" as String)
                .foregroundColor(w.getImage(value: w.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill" ? Color.green : Color.red)
                .frame(maxWidth: 600, alignment: .leading)
                .offset(x:20, y: -5)
            VStack{
                Text("\(w.getName(value: w.newoperation.firstIndex(of: value)!))" as String)
                    //\(w.getName(value: w.newoperation.firstIndex(of: value)!)) per aggiungere il nome dell'op
                    .frame(maxWidth: 300, alignment: .leading)
                    .offset(x:-127, y: 0)
                Text("\(w.getCategory(value: w.newoperation.firstIndex(of: value)!)) - \(w.getDate(value: w.newoperation.firstIndex(of: value)!))")
                    .font(.system(size: 14))
                    .frame(maxWidth: 600, alignment: .leading)
                    .offset(x:-127, y: 0)
            }
            Text("\(value)" as String)
                .offset(x:-10, y: 0)
        }
        Divider().offset(x: 0, y: -5)
    }
}
