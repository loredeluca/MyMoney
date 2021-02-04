//
//  InformationBlocks.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 29/01/2021.
//

import SwiftUI

extension ContentView {

    struct InfoBlock: View {
        @ObservedObject var c: Controls
        @ObservedObject var w : Wallet_Obs

        var body: some View {
            HStack{
                VStack{
                    SaldoDisponibile(c: c, w: w)
                    NavigationLink(destination: InfoGraphs(w: w)) {
                        BilancioMensile(c: c, w: w)
                    }//.buttonStyle(PlainButtonStyle())
                }
                Spacer().frame(width: 1)
                Budget(c: c, w: w)
            }
        }
    }
}





struct SaldoDisponibile: View {
    @ObservedObject var c: Controls
    @ObservedObject var w : Wallet_Obs
    
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .shadow(radius: 5.0)
                .foregroundColor(.white)
                .frame(width: 190, height: 75)
                .transition(.slide)
            VStack{
                Text("Saldo disponibile")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(.black)
                    .offset(x: 20, y: -5)
                Text("€ \(w.availableBalance, specifier: "%.2f")")//\(c.getCardTotBal(value: 0))")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(.black)
                    .offset(x: 20, y: 0)
            }
        }//endFirstZStack
    }
}

struct BilancioMensile: View{
    @ObservedObject var c: Controls
    @ObservedObject var w : Wallet_Obs
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .shadow(radius: 5.0)
                .foregroundColor(.white)
                .frame(width: 190, height: 105)
                .transition(.slide)
            VStack{
                Text("Bilancio Mensile")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(.black)
                    .offset(x: 20, y: -8)
                VStack{
                    Text("Totale € \(w.getTotal(), specifier: "%.2f")" )//+ String(w.getTotal()) )
                        .font(.system(size: c.didTapW[0] ? 18 : 15 ))
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, alignment: .leading)
                        .foregroundColor(.blue)
                        .offset(x: 20, y: -3)
                    Text("Entrate € \(w.getIn(), specifier: "%.2f")")// + String(w.getIn()) )
                        .font(.system(size: c.didTapW[1] ? 18 : 15))
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, alignment: .leading)
                        .foregroundColor(.green)
                        .offset(x: 20, y: 2)
                    Text("Uscite € \(w.getOut(), specifier: "%.2f")")// + String(w.getOut()) )
                        .font(.system(size: c.didTapW[2] ? 18 : 15))
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, alignment: .leading)
                        .foregroundColor(.red)
                        .offset(x: 20, y: 7)
                }
            }
        }
    }
}

struct Budget: View {
    @ObservedObject var c: Controls
    @ObservedObject var w : Wallet_Obs
    
    @State var progressValue: Float = 0.0
    @State private var isCircleRotating = true
    //@State var progressCircle: Float = 0.0
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .shadow(radius: 5.0)
                .foregroundColor(.white)
                .frame(width: 190, height: 190)
                .transition(.slide)
            VStack{
                Text("Budget Mensile")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(.black)
                    .offset(x: 20, y: 0)
                ZStack{
                    ProgressCircle(isCircleRotating: isCircleRotating, value1: $c.progressCircle)
                    Text("€ \(c.budget, specifier: "%.2f")")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                }
            }
        }
    }
}

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing){
                Rectangle().frame(width: 10 , height: geometry.size.width)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemGray6))
                
                Rectangle().frame(width: 10, height: min(CGFloat(self.value)*geometry.size.width, geometry.size.width))
                    .foregroundColor(self.value<0.36 ? Color(UIColor.systemYellow): (self.value<0.72 ? Color(UIColor.systemOrange): Color(UIColor.systemRed) ))
                    .animation(.linear)
            }
        }.frame(width: 65, height: 10)
    }
}

struct ProgressCircle: View {
    @State var isCircleRotating : Bool
    @Binding var value1: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .fill(Color.init(red: 0.96, green: 0.96, blue: 0.96))
                .shadow(radius: 0.0)
                .frame(width: 140, height: 140)
            
            Circle()
                .trim(from: CGFloat(value1))
                .stroke(lineWidth: 10)
                .rotationEffect(.degrees(isCircleRotating ? 360 : 0))
                .frame(width: 140, height: 140)
                .shadow(radius: 3.0)
                .foregroundColor(Color.blue) //color.card
        }
    }
}
