//
//  MainPage.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

/*
extension ContentView{
    struct LastTransaction: View{
        @ObservedObject var obTap: Controls
        
        var body: some View{
            Text("Transazioni recenti")
                .fontWeight(.bold)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding(.init(top: 0, leading: 0, bottom:0 , trailing: 200))
                .offset(y: 5)
            Spacer().frame(height: 10)
            //Seconda Parte
            VStack {
                HStack{
                //bottone 1
                    Button(action: {
                        obTap.didTapAllW1()
                    }, label: {
                    Text("Totale")
                })
                .frame(width: 70, height: 30)
                .foregroundColor(Color.black)
                .background(obTap.didTap[0] ? Color.blue : Color.gray)//.opacity(0.7)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                //bottone 2
                    Button(action: {
                        obTap.didTapInW1()
                    }, label: {
                    Text("Entrate")
                })
                .frame(width: 70, height: 30)
                .foregroundColor(Color.black)
                .background(obTap.didTap[1] ? Color.green : Color.gray)//.opacity(0.7)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                //bottone 3
                    Button(action: {
                        obTap.didTapOutW1()
                    }, label: {
                    Text("Uscite")
                })
                .frame(width: 70, height: 30)
                .foregroundColor(Color.black)
                .background(obTap.didTap[2] ? Color.red : Color.gray)//.opacity(0.7)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
            
                }.frame(width: 380, alignment: .leading)
                Spacer().frame(height:10)
            }
        }
    }

}

extension ContentView{
    struct ListTransaction: View {
        @ObservedObject var c: Controls
        @ObservedObject var w1: Wallet1_Obs
        //@ObservedObject var w2: Wallet1_Obs
        //@ObservedObject var w3: Wallet1_Obs
        
        var body: some View{
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    if w1.getCountImage()>0{//w1.getCountImage()>0{
                        //if obs.didTap[1]{
                        ForEach(w1.newoperation.reversed(), id: \.self) { value in
                            if c.didTap[0]{
                                transactionView(value: value, myw: w1)
                            }
                            if c.didTap[1] && w1.getImage(value: w1.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill"{
                                transactionView(value: value, myw: w1)
                            }
                            if c.didTap[2] && w1.getImage(value: w1.newoperation.firstIndex(of: value)!) == "chevron.down.circle.fill"{
                                transactionView(value: value, myw: w1)
                            }
                        }
                        //}//obs
                    }
                    /*
                    if c.e1() ? w1.getCountImage()>0 : (c.e2() ? w2.getCountImage()>0 : (c.e3() ? w3.getCountImage()>0 : false)){//w1.getCountImage()>0{
                        //if obs.didTap[1]{
                        ForEach(c.e1() ? w1.newoperation.reversed() : (c.e2() ? w2.newoperation.reversed() : (c.e3() ? w1.newoperation.reversed() : w1.newoperation.reversed())), id: \.self) { value in
                            if c.didTap[0]{
                                transactionView(value: value, myw: c.e1() ? w1 : (c.e2() ? w2 : (c.e3() ? w3 : w1)))
                            }
                            if c.didTap[1] && c.e1() ? w1.getImage(value: w1.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill" : (c.e2() ? w2.getImage(value: w2.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill" : (c.e3() ? w3.getImage(value: w3.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill" : false)){
                                transactionView(value: value, myw: c.e1() ? w1 : (c.e2() ? w2 : (c.e3() ? w3 : w1)))
                            }
                            if c.didTap[2] && c.e1() ? w1.getImage(value: w1.newoperation.firstIndex(of: value)!) == "chevron.down.circle.fill" : (c.e2() ? w2.getImage(value: w2.newoperation.firstIndex(of: value)!) == "chevron.down.circle.fill" : (c.e3() ? w3.getImage(value: w3.newoperation.firstIndex(of: value)!) == "chevron.down.circle.fill" : false)){
                                transactionView(value: value, myw: c.e1() ? w1 : (c.e2() ? w2 : (c.e3() ? w3 : w1)))
                            }
                        }
                        //}//obs
                    }*/
                }//.frame(height: 1)
            }
        }
    }
}

struct transactionView: View{
    var value : String
    @ObservedObject var myw : Wallet1_Obs
    //@ObservedObject var myw2 : Wallet1_Obs

    var body: some View{
        HStack{
            Image(systemName: "\(myw.getImage(value: myw.newoperation.firstIndex(of: value)!))" as String)
                .foregroundColor(myw.getImage(value: myw.newoperation.firstIndex(of: value)!) == "chevron.up.circle.fill" ? Color.green : Color.red)
                .frame(maxWidth: 300, alignment: .leading)
                .offset(x:20)
            VStack{
                Text("\(myw.getCategory(value: myw.newoperation.firstIndex(of: value)!))" as String) //\(myw.getName(value: myw.newoperation.firstIndex(of: value)!)) per aggiungere il nome dell'op
                    .frame(maxWidth: 300, alignment: .leading)
                    .offset(x:-127)
                Text("\(myw.getDate(value: myw.newoperation.firstIndex(of: value)!))")
                    .frame(maxWidth: 300, alignment: .leading)
                    .offset(x:-127)
            }
            Text("\(value)" as String)
                .offset(x:-10)
        }
        Divider()
    }
}
*/


