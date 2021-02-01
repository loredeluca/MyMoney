//
//  InfoGraphs.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 01/02/2021.
//

import SwiftUICharts
import SwiftUI

struct InfoGraphs: View {
    @ObservedObject var w1: Wallet1_Obs
    
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Color.green.opacity(0.7), secondGradientColor: Color.green, textColor: Color.black, legendTextColor: Color.white, dropShadowColor: .white )
    let chartStyle1 = ChartStyle(backgroundColor: Color.white, accentColor: Color.red.opacity(0.7), secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.white, dropShadowColor: .white )
    
    let inn = [50.0, 20.0, 1.0, 2.0, 3.0, 4.0]
    let out = [ 10.0, 5.0, 5.0]
    //360:100 = 90: x -->mod*100/360
    //farei partire da 285
    //da modificare la percentuale
    func trovapercentuali()->Float{
        let totalIn = w1.INOp.reduce(0, +)
        let totalOut = w1.OUTOp.reduce(0, +)
        
        let total = totalIn+totalOut
        //300:100 = 200 : x
        let percentualeIn = (totalIn*100)/total
        
        return percentualeIn
    }
    func perc()->Float{
        //360: 100 = x : 40
        return (trovapercentuali()*360)/100
    }
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date)
        
        return monthString + " " + yearString
    }
    
    
    
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .shadow(radius: 5.0)
                    .foregroundColor(.white)
                    .frame(width: 400, height: 280)
                    .transition(.slide)
                    .offset(x: 0, y: 20)
                HStack{
                    BarChartView(data: ChartData(points: w1.INOp), title: "Entrate", style: chartStyle, form: ChartForm.medium, valueSpecifier: "%.2f")
                    BarChartView(data: ChartData(points: w1.OUTOp), title: "Uscite", style: chartStyle1, form: ChartForm.medium, valueSpecifier: "%.2f")
                }
                Text("\(getDate())")
                    .font(.system(size: 21))
                    .bold()
                    .offset(x: 0, y: 140)
            }
            .offset(y: 10)
                
            Spacer().frame(height: 60)
        
            ZStack{
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .shadow(radius: 5.0)
                    .foregroundColor(.white)
                    .frame(width: 400, height: 450)
                    .transition(.slide)
                    .offset(x: 0, y: -20)
                
                ZStack{
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 130, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double(perc())), clockwise: false)
                    }
                    .fill(Color.green).opacity(0.8)
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 130, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double(perc())), clockwise: false)
                    }
                    .stroke(Color.green,lineWidth: 2)
                }
                .offset(x: 0, y: -70)
                
                ZStack{
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 130, startAngle: Angle(degrees: Double(perc())), endAngle: Angle(degrees: 0), clockwise: false)
                    }
                    .fill(Color.red).opacity(0.8)
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 130, startAngle: Angle(degrees: Double(perc())), endAngle: Angle(degrees: 0), clockwise: false)
                    }
                    .stroke(Color.red,lineWidth: 2)
                }
                .offset(x: 0, y: -70)
                
                ZStack{
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 75, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
                    }
                    .fill(Color.white).opacity(1.0)
                    .offset(x: 0, y: -70)
                    
                    VStack{
                        Text("Bilancio")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                        Spacer().frame(height: 5)
                        Text("\(w1.INOp.reduce(0, +)-w1.OUTOp.reduce(0, +), specifier: "%.2f")€")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                    }
                    .offset(x: -5, y: -100)
                }
                
                VStack{
                    Divider()
                        .frame(width: 400)
                        .offset(y: -15)
                    HStack{
                        HStack{
                            Image(systemName: "chevron.up.circle.fill")
                                .foregroundColor(.green)
                            Text("Entrate")
                                .font(.system(size: 21))
                                .bold()
                                .frame(width: 250, alignment: .leading)
                        }
                        VStack{
                            Text("\(trovapercentuali(), specifier: "%.2f")%")
                                .font(.system(size: 21))
                            Text("+ \(w1.INOp.reduce(0, +), specifier: "%.2f") €")
                                .font(.system(size: 21))
                        }
                    }
                    .offset(y: -15)
                    Divider()
                        .frame(width: 400)
                        .offset(y: -15)
                    HStack{
                        HStack{
                            Image(systemName: "chevron.down.circle.fill")
                                .foregroundColor(.red)
                            Text("Uscite")
                                .font(.system(size: 21))
                                .bold()
                                .frame(width: 250, alignment: .leading)
                        }
                        VStack{
                            Text("\(100-trovapercentuali(), specifier: "%.2f")%")
                                .font(.system(size: 21))
                            Text("- \(w1.OUTOp.reduce(0, +), specifier: "%.2f") €")
                                .font(.system(size: 21))
                        }
                    }
                    .offset(y: -15)
                    Divider()
                        .frame(width: 400)
                        .offset(y: -15)
                }
                .offset(y: 130)
            }
            .offset(y: 10)
        }
        .navigationBarTitle("Statistiche Bilancio Mensile", displayMode: .inline)
    }
}
/*
struct InfoGraphs_Previews: PreviewProvider {
    static var previews: some View {
        InfoGraphs()
    }
}
*/
