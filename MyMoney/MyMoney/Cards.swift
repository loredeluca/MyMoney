//
//  Cards.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

extension ContentView {
    struct Card1: View {
        @ObservedObject var controlli: Controls

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
                    controlli.toggle1()
                }){
                    Image(systemName:"info.circle")
                    //Text("Dettagli")
                }
                .offset(x: 160, y: -90)
                //.offset(x: 140, y: -90)
            }
            //.animation(.easeInOut)
            //.offset(x:0, y: controlli.e1() ? -10 : (controlli.e2() ? 750 : (controlli.e3() ? 750 : 100)) )
        }
    }

    struct Card2: View {
        @ObservedObject var controlli: Controls
        //@State var cardName : String
        //@State var cardCircuit : String
        
        var body: some View {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            //.resizable()
                            //.aspectRatio(contentMode: .fill)
                            .shadow(radius: 5.0)
                            .foregroundColor(controlli.getCardColor(value: 1))
                            .frame(width: 380, height: 237.5)
                            //.clipped()
                            //.cornerRadius(12)
                        Text(controlli.getCardName(value: 1))
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .frame(maxWidth: 300, alignment: .leading)
                            .foregroundColor(.white)
                            //.multilineTextAlignment(.leading)
                            .offset(x: -20, y: -90)
                        Button(action: {
                            controlli.toggle2()
                        }){
                            Image(systemName:"info.circle")
                            //Text("Dettagli")
                        }
                        .offset(x: 160, y: -90)
                        //.offset(x: 140, y: -90)
                        Image(controlli.getCardCircuit(value: 1))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 30)
                            .offset(x: 140, y: 70)
                    }
                //.animation(.easeInOut)
                //.offset(x: 0, y: controlli.e2() ? -10 : (controlli.e1() ? 750 : (controlli.e3() ? 750 : 150)))
        }
    }

    struct Card3: View {
        @ObservedObject var controlli: Controls
        
        var body: some View {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            //.resizable()
                            //.aspectRatio(contentMode: .fill)
                            .shadow(radius: 5.0)
                            .foregroundColor(controlli.getCardColor(value: 2))
                            .frame(width: 380, height: 237.5)
                            //.clipped()
                            //.cornerRadius(12)
                        Text(controlli.getCardName(value: 2))
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .frame(maxWidth: 300, alignment: .leading)
                            .foregroundColor(.white)
                            .offset(x: -20, y: -90)
                        Button(action: {
                            controlli.toggle3()
                        }){
                            Image(systemName:"info.circle")
                            //Text("Dettagli")
                        }
                        .offset(x: 160, y: -90)
                        //.offset(x: 140, y: -90)
                        Image(controlli.getCardCircuit(value: 2))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 30)
                            .offset(x: 140, y: 70)
                            //.clipped()
                            //.cornerRadius(12)
                    }
                //.animation(.easeInOut)
                //.offset(x: 0, y: controlli.e3() ? -10 : (controlli.e1() ? 750 : (controlli.e2() ? 750 : 200)))
        }
    }
}

