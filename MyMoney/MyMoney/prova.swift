//
//  prova.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

struct prova:View {
    
    //var midnight = Calendar.current.startOfDay(for: Date())
    //var tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!
    
    let tempGradient = Gradient(colors: [.red, .green])
    //5000:1=1:
    let data: [CGFloat] = [ 1.0002, 0.02,0.02,0.2]//-0.3,0.1,0.2,0.1,-1,0.4]
    //@State var on = true
    
    //@State var trim = CGFloat.zero
    
    
    let z : [Float] = [10,120,-40,30,1000,-300]
    @State var dati : [CGFloat] = []
    
    func conv(array : [Float]) ->[CGFloat]{
        for k in array{
            dati.append(CGFloat(k/1000))
        }
        return dati

    }

    
    
    
    
    //set Y
    func degreeHeight(_ height: CGFloat, range: Int) -> CGFloat {
      height / CGFloat(range)
    }
    
    func tempOffset(_ temperature: Double, degreeHeight: CGFloat) -> CGFloat {
      CGFloat(temperature + 10) * degreeHeight
    }
    
    func tempLabelOffset(_ line: Int, height: CGFloat) -> CGFloat {
      height - self.tempOffset(Double(line * 10),
                               degreeHeight: self.degreeHeight(height, range: 110))
    }
    
    //set X
    func dayWidth(_ width: CGFloat, count: Int) -> CGFloat {
      width / CGFloat(count)
    }
    
    func dayOffset(_ date: Date, dWidth: CGFloat) -> CGFloat {
      CGFloat(Calendar.current.ordinality(of: .day, in: .year, for: date)!) * dWidth
    }
    func offsetFirstOfMonth(_ month: Int, width: CGFloat) -> CGFloat {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "M/d/yyyy"
      let foM = dateFormatter.date(from: "\(month)/1/2018")!
      let dayWidth = self.dayWidth(width, count: 365)
      return self.dayOffset(foM, dWidth: dayWidth)
    }
    
    func monthAbbreviationFromInt(_ month: Int) -> String {
      let ma = Calendar.current.shortMonthSymbols
      return ma[month - 1]
    }
    
    var body: some View{
        VStack{
            Text("ok")
            
            //_ = self.conv(array: z)
            
            GeometryReader { reader in
                ForEach(1..<13) { measurement in
                    //x: 55-400 y: 180-0
                  Path { path in
                    path.move(to: CGPoint(x: 55, y: 180))
                    path.addLine(to: CGPoint(x: 100, y:50))
                    path.addLine(to: CGPoint(x:120, y:30))
                    path.addLine(to: CGPoint(x:120, y:30))
                    path.addLine(to: CGPoint(x:178, y:180))
                    path.addLine(to: CGPoint(x:400, y:30))
                  }
                  .stroke(lineWidth: 2)
                  .foregroundColor(.red)
                    
                    Path { path in
                      path.move(to: CGPoint(x: 55, y: 180))
                      path.addLine(to: CGPoint(x: 100, y:10))
                      path.addLine(to: CGPoint(x:120, y:20))
                      path.addLine(to: CGPoint(x:120, y:20))
                      path.addLine(to: CGPoint(x:178, y:40))
                      path.addLine(to: CGPoint(x:200, y:100))
                    }
                    .stroke(lineWidth: 2)
                    .foregroundColor(.green)
                  //.stroke(LinearGradient(startPoint: .init(x: 0.0, y: 1.0), endPoint: .init(x: 0.0, y: 0.0)))
                }
                
                ForEach(0..<11) { line in
                  Group {
                    Path { path in
                      let y = self.tempLabelOffset(line, height: reader.size.height)//CGFloat(10)
                      path.move(to: CGPoint(x: 0, y: y))
                      path.addLine(to: CGPoint(x: reader.size.width, y: y))
                    }
                    .stroke(line == 0 ? Color.black : Color.gray)
                    if line >= -10 {
                      Text("\(line * 10)€")
                        .font(.system(size: 10))
                        .offset(x: 10, y: self.tempLabelOffset(line, height: reader.size.height))
                    }
                  }
                }//end forEach1
                
                ForEach(1..<5) { month in
                  Group {
                    Path { path in
                      let dOffset = 40+15*CGFloat(month)//*reader.size.width/CGFloat(month)
                      
                        path.move(to: CGPoint(x: dOffset, y: reader.size.height-20))
                        path.addLine(to: CGPoint(x: dOffset, y: 0))
                    }.stroke(Color.gray)
                    Text("\(month)")
                      //.font(.subheadline)
                        .font(.system(size: 5))
                        .offset(
                            x: 40+15*CGFloat(month),//reader.size.width - 400.0 + 20*CGFloat(month),
                            y: reader.size.height - 25.0)
                  }
                }//endForEach2

            }
            .frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            /*
            ZStack{
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 300, height: 200)
                
                Path{ path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    
                    path.addLine(to: CGPoint(x:0, y:0))
                    path.addLine(to: CGPoint(x:20, y:-30))
                    path.addLine(to: CGPoint(x:20, y:30))
                    path.addLine(to: CGPoint(x:78, y:-40))
                    path.addLine(to: CGPoint(x:100, y:-40))
                }
                .trim(to: self.trim)
                .stroke(lineWidth: 2)
                .foregroundColor(.blue)
                .frame(width: 100, height: 100, alignment: .center)
                
                .animation(Animation.easeInOut(duration: 1))
                .onAppear{self.trim = CGFloat(1.0)}
                //.rotationEffect(.degrees(180), anchor: .center)
                //.rotation3DEffect(.degrees(180), axis: (x:0.0, y:0.0,z:0.0), anchor: .center)
                .offset(x: 10, y: 40)
            }*/
            
            
            
            
            
            
            /*
            LineGraph(dataPoints: data)
                .trim(to: 1)//on ? 0 : 1)
                .stroke(LinearGradient(
                  gradient: self.tempGradient,
                  startPoint: .init(x: 0.0, y: 1.0),
                  endPoint: .init(x: 0.0, y: 0.5)),
                  lineWidth: 2)
                //.stroke(Color.red, lineWidth: 2)
                .aspectRatio(16/9, contentMode: .fit)
                .border(Color.gray, width: 1)
                .padding()
            /*Button("Animate") {
                withAnimation(.easeInOut(duration: 5)) {
                    self.on.toggle()
                }
            }*/
            .offset(x: 0, y: 0)
            
            Text("\(midnight)")
            Text("___")
            Text("\(tomorrow)")*/


        }
    }
}

struct prova_Previews: PreviewProvider {
  static var previews: some View {
    prova()
  }
}


struct LineGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = 40 + rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1-point) * rect.height
            return CGPoint(x: x, y: y)
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 40, y: (1-start) * rect.height))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
}





/*struct prova: View {
    
    @State var on = true
    let data: [CGFloat] = [ 0.1,0.3,0.1,0.2,0.1,0.7,0.4]
    
    var body: some View{
        VStack {
            LineGraph(dataPoints: data)
                            .trim(to: on ? 0 : 1)
                            .stroke(Color.red, lineWidth: 2)
                            .aspectRatio(16/9, contentMode: .fit)
                            .border(Color.gray, width: 1)
                            .padding()
            Button("Animate") {
                withAnimation(.easeInOut(duration: 5)) {
                    self.on.toggle()
                }
            }
            .offset(x: 0, y: 0)

        }
        .navigationBarTitle("Bilancio Mensile", displayMode: .inline)
    }
}
//BOZZA PER FARE I GRAFICI
struct LineGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1-point) * rect.height
            return CGPoint(x: x, y: y)
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (1-start) * rect.height))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
}
*/

