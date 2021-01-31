//
//  ContentView.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controlli = Controls()
    @ObservedObject var wallet1 = Wallet1_Obs()
    
    //@State var b: String = ""
    @State var setBudget = false

    var body: some View {
        NavigationView{
            VStack {
                //Carte
                ZStack{
                    if controlli.thereiscard[0]{
                        VStack{
                            Card1(controlli: controlli)
                                .animation(.easeInOut)
                                .offset(x:0, y: controlli.e1() ? 0 : (controlli.e2() ? 750 : (controlli.e3() ? 750 : 100)) )
                            InfoBlock1(c: controlli, w1: wallet1)
                                .animation(.easeInOut)
                                .offset(x:0, y: controlli.expanded1 ? 0 : (controlli.expanded2 ? 750 : (controlli.expanded3 ? 750 : 750))) //inveec di 0, vale 215
                            LastTransaction1(c: controlli, w1: wallet1)
                                .animation(.easeInOut)
                                .offset(x:0, y: controlli.expanded1 ? 0 : (controlli.expanded2 ? 750 : (controlli.expanded3 ? 750 : 750)))
                        }
                    }
                    if controlli.thereiscard[1]{
                        VStack{
                            Card2(controlli: controlli)
                                .animation(.easeInOut)
                                .offset(x: 0, y: controlli.e2() ? -10 : (controlli.e1() ? 750 : (controlli.e3() ? 750 : -70)))
                        }
                    }
                    if controlli.thereiscard[2]{
                        Card3(controlli: controlli)
                            .animation(.easeInOut)
                            .offset(x: 0, y: controlli.e3() ? -10 : (controlli.e1() ? 750 : (controlli.e2() ? 750 : -120)))
                    }
                }
                
                //Pulsante Aggiungi Carte
                NewCardSheet(c: controlli, w1: wallet1)
                    .offset(x: 0, y: setBudget ? 105 : -50)
                    .disabled(setBudget)
                
                //AddBudget
                if setBudget{
                    AddBugdet(c: controlli,setBudget: $setBudget)
                }
                
                
                
            }//endPrimoVStack
            .navigationBarTitle("Personal Finance")
            .navigationBarItems(
                trailing:
                    NewTransactionSheet(c: controlli, w1: wallet1)
            )
            //FUNZIONA MA decidere cosa scrivere
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Menu{
                        Section{
                            Button(action: {
                                setBudget.toggle()
                            }) {
                                Label("New Budget", systemImage: "archivebox")
                                        .foregroundColor(.red)
                            }
                            Button(action: {
                                delete2()
                            }) {
                                Label("Remove old files", systemImage: "trash")
                                        .foregroundColor(.red)
                            }
                        }
                    }
                    label: {
                        Label("Add", systemImage: "gear") .font(.system(size: 23))
                    }
                }
                /*ToolbarItem(placement: .navigationBarTrailing){
                    PROVA(c: controlli, w1: wallet1)
                    //PLUS(controlli: controlli ,mywallet: wallet1)
                }*/
            }//endToolbar
        }//endNavigationView
        
    }
    
    
    //Funzioni
    
    
    
    func delete2(){
        //card.remove(at: 2)
        controlli.thereiscard[2] = false
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
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

//dati
@State var on = true

let data: [CGFloat] = [ 0.1,0.3,0.1,0.2,0.1,0.7,0.4] //più ne metti più ne aggiunge
//questo va incollato nel var body
LineGraph(dataPoints: data)
                .trim(to: on ? 1 : 0)
                .stroke(Color.red, lineWidth: 2)
                .aspectRatio(16/9, contentMode: .fit)
                .border(Color.gray, width: 1)
                .padding()
Button("Animate") {
    withAnimation(.easeInOut(duration: 2)) {
        self.on.toggle()
    }
}
.offset(x: 0, y: setBudget ? 105 : -50)*/
