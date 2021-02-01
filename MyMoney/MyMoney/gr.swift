//
//  gr.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 31/01/2021.
//

import SwiftUI

struct gr: View {
    @State var on = true

    //set Y
    func degreeHeight(_ height: CGFloat, range: Int) -> CGFloat {
      height / CGFloat(range)
    }
    
    func tempOffset(_ temperature: Double, degreeHeight: CGFloat) -> CGFloat {
      CGFloat(temperature + 10) * degreeHeight
    }
    
    func tempLabelOffset(_ line: Int, height: CGFloat) -> CGFloat {
        height - self.tempOffset(Double(line * 10), degreeHeight: self.degreeHeight(height, range: 110))
    }
    @State var X = [ 10.0, 20.0, 100.0]
    @State var Y = []
    
    func converti(value : Float) -> CGFloat {
        return CGFloat((Double(value) - X.min()!) / (X.max()! - X.min()!))
    }
    
    
    let data: [CGFloat] = [ 0.1,0.3,0.1,0.8] //più ne metti più ne aggiung
    let data1: [CGFloat] = [ 0.0,0.4,0.1,1.0,0.1,0.7]
   
    var body: some View {
        VStack{
           
            
            /*ZStack{
                ForEach(data, id: \.self) { x in
                    Text("\(x)")
                        .offset(x: 2, y: CGFloat(400*x))
                    }
            }*/
            GeometryReader { reader in
                LineGraph1(dataPoints: data)
                                .trim(to: on ? 1 : 0)
                                .stroke(Color.red, lineWidth: 2)
                                .aspectRatio(16/9, contentMode: .fit)
                                //.border(Color.gray, width: 1)
                                .padding()
                    .frame(width: 500, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: -52, y: -52)
                LineGraph1(dataPoints: data1)
                                .trim(to: on ? 1 : 0)
                                .stroke(Color.green, lineWidth: 2)
                                .aspectRatio(16/9, contentMode: .fit)
                                //.border(Color.gray, width: 1)
                                .padding()
                    .frame(width: 500, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: -52, y: -52)
                
                ForEach(0..<13) { line in
                  Group {
                    Path { path in
                      let y = self.tempLabelOffset(line, height: reader.size.height)//CGFloat(10)
                      path.move(to: CGPoint(x: 0, y: y))
                      path.addLine(to: CGPoint(x: reader.size.width, y: y))
                    }
                    .stroke(line == 0 ? Color.black : Color.gray)
                    /*if line >= -10 {
                        Text("\(data.max()!)")
                        .font(.system(size: 10))
                        .offset(x: 10, y: self.tempLabelOffset(line, height: reader.size.height))
                    }*/
                  }
                }//end forEach1
                Text("\(data.max()!)")
                .font(.system(size: 10))
                    .offset(x: 0, y: -10*data.max()!)//self.tempLabelOffset(12, height: reader.size.height))
                Text("\(data1.max()!)")
                .font(.system(size: 10))
                    .offset(x: 0, y: data.max()!)
            }
            .frame(width: 390, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            
            Button("Animate") {
                withAnimation(.easeInOut(duration: 2)) {
                    self.on.toggle()
                }
            }
            .offset(x: 0, y: 0)
        }
    }
}

struct gr_Previews: PreviewProvider {
    static var previews: some View {
        gr()
    }
}



struct LineGraph1: Shape {
    var dataPoints: [CGFloat]
    //var dataPoints1: [CGFloat]

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

