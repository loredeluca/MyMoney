//
//  InformationBlocks.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 29/01/2021.
//

import SwiftUI

extension ContentView {

    struct InfoBlock1: View {
        @ObservedObject var c: Controls
        @ObservedObject var w1 : Wallet1_Obs

        var body: some View {
            HStack{
                VStack{
                    SaldoDisponibile1(c: c, w1: w1)
                    BilancioMensile1(c: c, w1: w1)
                }
                Spacer().frame(width: 1)
                Budget1(c: c, w1: w1)
            }
            //.animation(.easeInOut)
            //.offset(x:0, y: c.expanded1 ? 0 : (c.expanded2 ? 750 : (c.expanded3 ? 750 : 750))) //inveec di 0, vale 215
            
        }
    }
    
    //InfoBlock2
    //InfoBlock3
}





struct SaldoDisponibile1: View {
    @ObservedObject var c: Controls
    @ObservedObject var w1 : Wallet1_Obs
    
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
                Text("€ \(w1.availableBalance, specifier: "%.2f")")//\(c.getCardTotBal(value: 0))")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .frame(maxWidth: 300, alignment: .leading)
                    .foregroundColor(.black)
                    .offset(x: 20, y: 0)
            }
        }//endFirstZStack
    }
}

struct BilancioMensile1: View{
    @ObservedObject var c: Controls
    @ObservedObject var w1 : Wallet1_Obs
    
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
                    Text("Totale € " + String(w1.getTotal()) )
                        .font(.system(size: c.didTapW1[0] ? 18 : 15 ))
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, alignment: .leading)
                        .foregroundColor(.blue)
                        .offset(x: 20, y: -3)
                    Text("Entrate € " + String(w1.getIn()) )
                        .font(.system(size: c.didTapW1[1] ? 18 : 15))
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, alignment: .leading)
                        .foregroundColor(.green)
                        .offset(x: 20, y: 2)
                    Text("Uscite € " + String(w1.getOut()) )
                        .font(.system(size: c.didTapW1[2] ? 18 : 15))
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, alignment: .leading)
                        .foregroundColor(.red)
                        .offset(x: 20, y: 7)
                }
            }
        }
    }
}

struct Budget1: View {
    @ObservedObject var c: Controls
    @ObservedObject var w1 : Wallet1_Obs
    
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
