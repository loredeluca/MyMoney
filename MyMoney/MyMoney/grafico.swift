//
//  grafico.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 31/01/2021.
//

import SwiftUICharts
import SwiftUI

struct grafico: View {
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Color.green.opacity(0.7), secondGradientColor: Color.green, textColor: Color.black, legendTextColor: Color.white, dropShadowColor: .white )
    let chartStyle1 = ChartStyle(backgroundColor: Color.white, accentColor: Color.red.opacity(0.7), secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.white, dropShadowColor: .white )
    let tempGradient = Gradient(colors: [
                                  .red, .green])
    
    
    var body: some View {
        VStack{
            HStack{
                BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Entrate", style: chartStyle, form: ChartForm.medium, valueSpecifier: "%.2f")
                BarChartView(data: ChartData(points: [34,103,44,4,22,12,56,90]), title: "Uscite", style: chartStyle1, form: ChartForm.medium, valueSpecifier: "%.2f")
            }
            /*HStack{
                //BarChartView(data: ChartData(points: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188]), title: "Title", legend: "Entrate") // legend is optional 100:80=x:50
                let chartStyle3 = ChartStyle(backgroundColor: Color.gray, accentColor: Color.green, secondGradientColor: Color.green, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray)
                PieChartView(data: [50,30], title: "Title", legend: "\(100*50/80)%U, \(100*30/80)%U", style: chartStyle3)
                BarChartView(data: ChartData(points:[1.23,2.43,3.37]) ,title: "A", style: chartStyle3, valueSpecifier: "%.1f")
                
            }*/
            
            //let chartStyle2 = chartStyle()
            let mod = 100
            //360:100 = 90: x -->mod*100/360
            //farei partire da 285
            //da modificare la percentuale

            HStack{
                ZStack{
                    
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double(mod)), clockwise: false)
                    }
                    .fill(Color.green).opacity(0.8)
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double(mod)-0), clockwise: false)
                    }
                    .stroke(Color.green,lineWidth: 2)
                    Text("\(mod*100/360)%")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .offset(x: 175, y: -150)
                }
                
                ZStack{
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: Double(mod)), endAngle: Angle(degrees: 0), clockwise: false)
                    }
                    .fill(Color.red).opacity(0.8)
                    .offset(x: -210, y: 0)
                    Path{ path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: Double(mod)), endAngle: Angle(degrees: 0), clockwise: false)
                    }
                    .stroke(Color.red,lineWidth: 2)
                    .offset(x: -210, y: 0)
                    Text("\((360-mod)*100/360)%")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .offset(x: -175, y: -20)
                }
                
                
                
                
                
                /*BarChartView(data: ChartData(points:[1.23,2.43,3.37]), title: "Title", style: chartStyle)

                LineChartView(data: [10,20,30,40], title: "Line chart", style: chartStyle)*/
            }
        }
    }
}

struct grafico_Previews: PreviewProvider {
    static var previews: some View {
        grafico()
    }
}
 
 
/*
import SwiftUI

public struct LineChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    //@ObservedObject var data:ChartData
    public var title: String
    public var legend: String?
    //public var style: ChartStyle
    //public var darkModeStyle: ChartStyle
    
    public var formSize:CGSize
    public var dropShadow: Bool
    public var valueSpecifier:String
    
    @State private var touchLocation:CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    @State private var currentValue: Double = 2 {
        didSet{
            if (oldValue != self.currentValue && showIndicatorDot) {
                HapticFeedback.playSelection()
            }
            
        }
    }
    var frame = CGSize(width: 180, height: 120)
    private var rateValue: Int?
    
    public init(data: [Double],
                title: String,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                form: CGSize? = ChartForm.medium,
                rateValue: Int? = 14,
                dropShadow: Bool? = true,
                valueSpecifier: String? = "%.1f") {
        
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.formSize = form!
        frame = CGSize(width: self.formSize.width, height: self.formSize.height/2)
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
        self.rateValue = rateValue
    }
    
    public var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 20)
                .fill(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
                .frame(width: frame.width, height: 240, alignment: .center)
                .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 8 : 0)
            VStack(alignment: .leading){
                if(!self.showIndicatorDot){
                    VStack(alignment: .leading, spacing: 8){
                        Text(self.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                        if (self.legend != nil){
                            Text(self.legend!)
                                .font(.callout)
                                .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor :self.style.legendTextColor)
                        }
                        HStack {
                            
                            if (self.rateValue ?? 0 != 0)
                            {
                                if (self.rateValue ?? 0 >= 0){
                                    Image(systemName: "arrow.up")
                                }else{
                                    Image(systemName: "arrow.down")
                                }
                                Text("\(self.rateValue!)%")
                            }
                        }
                    }
                    .transition(.opacity)
                    .animation(.easeIn(duration: 0.1))
                    .padding([.leading, .top])
                }else{
                    HStack{
                        Spacer()
                        Text("\(self.currentValue, specifier: self.valueSpecifier)")
                            .font(.system(size: 41, weight: .bold, design: .default))
                            .offset(x: 0, y: 30)
                        Spacer()
                    }
                    .transition(.scale)
                }
                Spacer()
                GeometryReader{ geometry in
                    Line(data: self.data,
                         frame: .constant(geometry.frame(in: .local)),
                         touchLocation: self.$touchLocation,
                         showIndicator: self.$showIndicatorDot,
                         minDataValue: .constant(nil),
                         maxDataValue: .constant(nil)
                    )
                }
                .frame(width: frame.width, height: frame.height + 30)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: 0, y: 0)
            }.frame(width: self.formSize.width, height: self.formSize.height)
        }
        .gesture(DragGesture()
        .onChanged({ value in
            self.touchLocation = value.location
            self.showIndicatorDot = true
            self.getClosestDataPoint(toPoint: value.location, width:self.frame.width, height: self.frame.height)
        })
            .onEnded({ value in
                self.showIndicatorDot = false
            })
        )
    }
    
    @discardableResult func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(round((toPoint.x)/stepWidth))
        if (index >= 0 && index < points.count){
            self.currentValue = points[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Basic")
                .environment(\.colorScheme, .light)
            
            LineChartView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188], title: "Line chart", legend: "Basic")
            .environment(\.colorScheme, .light)
        }
    }
}
*/

/*
public struct LineView: View {
    @ObservedObject var data: ChartData
    public var title: String?
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    public var valueSpecifier:String
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var showLegend = false
    @State private var dragLocation:CGPoint = .zero
    @State private var indicatorLocation:CGPoint = .zero
    @State private var closestPoint: CGPoint = .zero
    @State private var opacity:Double = 0
    @State private var currentDataNumber: Double = 0
    @State private var hideHorizontalLines: Bool = false
    
    public init(data: [Double],
                title: String? = nil,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                valueSpecifier: String? = "%.1f") {
        
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.valueSpecifier = valueSpecifier!
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
    }
    
    public var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 8) {
                ZStack{
                    GeometryReader{ reader in
                        Rectangle()
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
                        Line(data: self.data,
                             frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 30, height: reader.frame(in: .local).height)),
                             touchLocation: self.$indicatorLocation,
                             showIndicator: self.$hideHorizontalLines,
                             minDataValue: .constant(nil),
                             maxDataValue: .constant(nil),
                             showBackground: false,
                             gradient: self.style.gradientColor
                        )
                        .offset(x: 30, y: -20)
                        .onAppear(){
                            self.showLegend = true
                        }
                        .onDisappear(){
                            self.showLegend = false
                        }
                    }
                    .frame(width: geometry.frame(in: .local).size.width, height: 240)
                    .offset(x: 0, y: 40 )
                    MagnifierRect(currentNumber: self.$currentDataNumber, valueSpecifier: self.valueSpecifier)
                        .opacity(self.opacity)
                        .offset(x: self.dragLocation.x - geometry.frame(in: .local).size.width/2, y: 36)
                }
                .frame(width: geometry.frame(in: .local).size.width, height: 240)
                .gesture(DragGesture()
                .onChanged({ value in
                    self.dragLocation = value.location
                    self.indicatorLocation = CGPoint(x: max(value.location.x-30,0), y: 32)
                    self.opacity = 1
                    self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width-30, height: 240)
                    self.hideHorizontalLines = true
                })
                    .onEnded({ value in
                        self.opacity = 0
                        self.hideHorizontalLines = false
                    })
                )
            }
        }
    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(floor((toPoint.x-15)/stepWidth))
        if (index >= 0 && index < points.count){
            self.currentDataNumber = points[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineView(data: [8,23,54,32,12,37,7,23,43], title: "Full chart", style: Styles.lineChartStyleOne)
            
            LineView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188], title: "Full chart", style: Styles.lineChartStyleOne)
            
        }
    }
}

*/
