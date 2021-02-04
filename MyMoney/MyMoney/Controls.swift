//
//  Controls.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

class Controls: ObservableObject{
    
    @Published var thereiscard : [Bool] = [true, false, false]
    @Published var card : [String] = ["portafoglio"]
    
    func cardAppend(value: String){
        card.append(value)
    }
    func cardCount()->Int{
        return card.count
    }
    
    // FIRST PAGE
    @Published var expanded1: Bool = false
    @Published var expanded2: Bool = false
    @Published var expanded3: Bool = false
    
    // Espansioni
    func toggle1(){
        expanded1.toggle()
    }
    func toggle2(){
        expanded2.toggle()
    }
    func toggle3(){
        expanded3.toggle()
    }

    func e1()->Bool{
        return expanded1
    }
    func e2()->Bool{
        return expanded2
    }
    func e3()->Bool{
        return expanded3
    }
    
    //SHEET CARD
    @Published var myCard: [(name: String, circuit: String)] = [("portafoglio", "None")]
    @Published var cardColor: [Color] = [.white, .white, .white]
    
    //Card Name
    func app(name : String, circuit: String){
        myCard.append((name: name, circuit: circuit))
    }
    func getCardName(value: Int)->String{
        return myCard[value].name
    }
    func setCardName(value:Int, n: String){
        myCard[value].name = n
    }
    
    //Card Circuit
    func getCardCircuit(value: Int)->String{
        return myCard[value].circuit
    }
    func setCardCircuit(value:Int, c: String){
        myCard[value].circuit = c
    }
    
    //Card Color
    func setCardColor(value: Int, color: Color){
        cardColor[value] = color
    }
    func getCardColor(value: Int)->Color{
        return cardColor[value]
    }
    
    //BUDGET
    @Published var budget : Float = 0.0
    @Published var progressCircle : Float = 0.0
    @Published var tmp : Float = 0.0
    
    func setBudget(value: Float){
        budget = value
        tmp = budget
    }
    func updateBudget(value: Float){
        budget = budget - value
        self.progressCircle += (1 * value)/tmp
    }
    
     func resetCircleBudget() {
         self.progressCircle = 0.0
        budget = tmp
     }
    
    //WALLET
    @Published var sheetTotW: Bool = false
    @Published var sheetInW: Bool = false
    @Published var sheetOutW: Bool = false
    
    func toggleSheetTotW(){
        sheetTotW.toggle()
    }
    func TotW()->Bool{
        return sheetTotW
    }
    func toggleSheetInW(){
        sheetInW.toggle()
    }
    func InW()->Bool{
        return sheetInW
    }
    func toggleSheetOutW(){
        sheetOutW.toggle()
    }
    func OutW()->Bool{
        return sheetOutW
    }
    
    //LatestTransaction
    @Published var didTapW = [true, false, false]
    
    func didTapAllW(){
        didTapW[0] = true
        didTapW[1] = false
        didTapW[2] = false
    }
    func didTapInW(){
        didTapW[1] = true
        didTapW[0] = false
        didTapW[2] = false
    }
    func didTapOutW(){
        didTapW[2] = true
        didTapW[0] = false
        didTapW[1] = false
    }
    
    
    //plusSheet
    @Published var sheetNewTransaction : Bool = false
    
    func toggleSheetPlus(){
        sheetNewTransaction.toggle()
    }
    func sheetPlus()->Bool{
        return sheetNewTransaction
    }
}
