//
//  Cards.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

extension ContentView {
    struct Card1: View {
        @ObservedObject var controls: Controls
        
        //popup
        @State var firstTime = true
        @State var alert = false

        var body: some View {
            ZStack{
                Image("portafoglio")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 5.0)
                    .frame(width: 380, height: 237.5)
                    .clipped()
                    .cornerRadius(12)
                Button(action: {
                    controls.toggle1()
                    if firstTime{
                        alert.toggle()
                        firstTime = false
                    }
                }){
                    Image(systemName:"info.circle")
                }
                .offset(x: 160, y: -90)
                .alert(isPresented: $alert) {
                    Alert(title: Text("Vuoi inserire il saldo disponibile?"), message: Text("impostazioni > Nuovo Saldo Disponibile"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }

    struct Card2: View {
        @ObservedObject var controls: Controls

        @State var firstTime = true
        @State var alert = false
        
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .shadow(radius: 5.0)
                    .foregroundColor(controls.getCardColor(value: 1))
                    .frame(width: 380, height: 237.5)
                Text(controls.getCardName(value: 1))
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(.white)
                    .offset(x: -20, y: -90)
                Button(action: {
                    controls.toggle2()
                    if firstTime{
                        alert.toggle()
                        firstTime = false
                    }
                }){
                    Image(systemName:"info.circle")
                }
                .offset(x: 160, y: -90)
                .alert(isPresented: $alert) {
                    Alert(title: Text("Vuoi inserire un budget mensile?"), message: Text("impostazioni > Nuovo Budget"), dismissButton: .default(Text("OK")))
                }
                //.offset(x: 140, y: -90)
                Image(controls.getCardCircuit(value: 1))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 30)
                    .offset(x: 140, y: 70)
            }
        }
    }

    struct Card3: View {
        @ObservedObject var controls: Controls
        
        @State var firstTime = true
        @State var alert = false
        
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .shadow(radius: 5.0)
                    .foregroundColor(controls.getCardColor(value: 2))
                    .frame(width: 380, height: 237.5)
                Text(controls.getCardName(value: 2))
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(.white)
                    .offset(x: -20, y: -90)
                Button(action: {
                    controls.toggle3()
                    if firstTime{
                        alert.toggle()
                        firstTime = false
                    }
                }){
                    Image(systemName:"info.circle")
                }
                .offset(x: 160, y: -90)
                .alert(isPresented: $alert) {
                    Alert(title: Text("Vuoi inserire un budget mensile?"), message: Text("impostazioni > Nuovo Budget"), dismissButton: .default(Text("OK")))
                }
                //.offset(x: 140, y: -90)
                Image(controls.getCardCircuit(value: 2))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 30)
                    .offset(x: 140, y: 70)
            }
        }
    }
}

