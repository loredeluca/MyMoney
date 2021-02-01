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
     
    
    
    
    //WALLET1
    @Published var sheetTotW1: Bool = false
    @Published var sheetInW1: Bool = false
    @Published var sheetOutW1: Bool = false
    
    func toggleSheetTotW1(){
        sheetTotW1.toggle()
    }
    func TotW1()->Bool{
        return sheetTotW1
    }
    func toggleSheetInW1(){
        sheetInW1.toggle()
    }
    func InW1()->Bool{
        return sheetInW1
    }
    func toggleSheetOutW1(){
        sheetOutW1.toggle()
    }
    func OutW1()->Bool{
        return sheetOutW1
    }
    
    //LastTransaction //USATI PER DAVVERO IN LATEST TRANSACTION
    @Published var didTapW1 = [true, false, false]
    
    func didTapAllW1(){
        didTapW1[0] = true
        didTapW1[1] = false
        didTapW1[2] = false
    }
    func didTapInW1(){
        didTapW1[1] = true
        didTapW1[0] = false
        didTapW1[2] = false
    }
    func didTapOutW1(){
        didTapW1[2] = true
        didTapW1[0] = false
        didTapW1[1] = false
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
