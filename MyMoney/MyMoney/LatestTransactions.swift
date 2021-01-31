//
//  LatestTransactions.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 29/01/2021.
//

import SwiftUI

extension ContentView{
    struct LastTransaction1: View {
        @ObservedObject var c: Controls
        @ObservedObject var w1: Wallet1_Obs
        
        var body: some View {
            VStack{
                TitleTransaction()
                ButtonsTransaction1(c: c)
                ListTransactions1(c: c, w1: w1)
            }
            //.animation(.easeInOut)
            //.offset(x:0, y: c.expanded1 ? 0 : (c.expanded2 ? 750 : (c.expanded3 ? 750 : 750)))
        }
    }
    
    //LastTransaction2
    //LastTransaction3
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

struct ButtonsTransaction1: View {
    @ObservedObject var c: Controls
    
    var body: some View{
        HStack{
        //bottone 1
            Button(action: {
                c.didTapAllW1()
            }, label: {
            Text("Totale")
        })
        .frame(width: 70, height: 30)
        .foregroundColor(Color.black)
        .background(c.didTapW1[0] ? Color.blue : Color.gray)//.opacity(0.7)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
            
        //bottone 2
            Button(action: {
                c.didTapInW1()
            }, label: {
            Text("Entrate")
        })
        .frame(width: 70, height: 30)
        .foregroundColor(Color.black)
        .background(c.didTapW1[1] ? Color.green : Color.gray)//.opacity(0.7)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
            
        //bottone 3
            Button(action: {
                c.didTapOutW1()
            }, label: {
            Text("Uscite")
        })
        .frame(width: 70, height: 30)
        .foregroundColor(Color.black)
        .background(c.didTapW1[2] ? Color.red : Color.gray)//.opacity(0.7)
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
    
        }
        .frame(width: 380, alignment: .leading)
    
        Spacer().frame(height:10)
    }
}

struct ListTransactions1: View{
    @ObservedObject var c: Controls
    @ObservedObject var w1: Wallet1_Obs
    
    var body: some View{
        ScrollView(.vertical) {
            VStack(spacing: 5) {
                if w1.getCountImage()>0{ //controllo se c'è almeno un elemento
                    ForEach(w1.newoperation.reversed(), id: \.self) { value in
                        //mostra Tutte le transazioni
                        if c.didTapW1[0]{
                            transactionView1(value: value, w1: w1)
                        }
                        //mostra le Entrate
                        if c.didTapW1[1] && w1.getImage(value: w1.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill"{
                            transactionView1(value: value, w1: w1)
                        }
                        //mostra le Uscite
                        if c.didTapW1[2] && w1.getImage(value: w1.newoperation.firstIndex(of: value)!) == "chevron.down.circle.fill"{
                            transactionView1(value: value, w1: w1)
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct transactionView1: View{
    var value : String
    @ObservedObject var w1 : Wallet1_Obs
    //@ObservedObject var myw2 : Wallet1_Obs

    var body: some View{
        HStack{
            Image(systemName: "\(w1.getImage(value: w1.newoperation.firstIndex(of: value)!))" as String)
                .foregroundColor(w1.getImage(value: w1.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill" ? Color.green : Color.red)
                .frame(maxWidth: 600, alignment: .leading)
                .offset(x:20, y: -5)
            VStack{
                Text("\(w1.getName(value: w1.newoperation.firstIndex(of: value)!))" as String)
                    //\(w1.getName(value: w1.newoperation.firstIndex(of: value)!)) per aggiungere il nome dell'op
                    .frame(maxWidth: 300, alignment: .leading)
                    .offset(x:-127, y: 0)
                Text("\(w1.getCategory(value: w1.newoperation.firstIndex(of: value)!)) - \(w1.getDate(value: w1.newoperation.firstIndex(of: value)!))")
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
