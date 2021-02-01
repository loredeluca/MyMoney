//
//  Wallet1_Obs.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

class Wallet1_Obs: ObservableObject{
    //wallet = [Total, in, out]
    @Published var wallet : [Float] = [0, 0, 0]
    @Published var newoperation : [String] = []
    @Published var newcategory : [String] = []
    @Published var image : [String] = []
    @Published var operationName : [String] = []
    @Published var date = []

    
    //Entrate
    @Published var entryOperation : [String] = []
    @Published var entryCategory : [String] = []
    @Published var INOp : [Float] = []
    //Uscite
    @Published var exitOperation : [String] = []
    @Published var exitCategory : [String] = []
    @Published var OUTOp : [Float] = []
    
    func addINOp(value: Float){
        INOp.append(value)
    }
    func addOUTOp(value: Float){
        OUTOp.append(value)
    }
    
    
    //Saldo disponibile
    @Published var  availableBalance : Float = 0.0 //da settare
    @Published var tmp_ab : Float = 0.0
    
    func setAvailableBalance(value: Float){
        availableBalance = value
        tmp_ab = availableBalance
    }
    func addAvailableBalance(value: Float){
        availableBalance = availableBalance + value
    }
    func reduceAvailableBalance(value: Float){
        availableBalance = availableBalance - value
    }
    
    //Budget
    //@Published var budget = 1000
    //Controlli per budget e attività mensile
    //@Published var progressValue: Float = 0.0
    //@Published var isCircleRotating = true
    //@Published var progressCircle: Float = 0.0

    
    //wallet1
    func add(value: Float){
        wallet[1] = wallet[1] + value
        total()
        addAvailableBalance(value: Float(value))
    }
    func remove(value: Float){
        wallet[2] = wallet[2] - value
        total()
        reduceAvailableBalance(value: Float(value))
    }
    func total(){
        wallet[0] = wallet[1]-abs(wallet[2])
    }
    func getIn() -> Float {
        return wallet[1]
    }
    func getOut() -> Float {
        return abs(wallet[2])
    }
    func getTotal() -> Float {
        return wallet[0]
    }
    
    //newOperation
    func addOperation(value: String){
        newoperation.append(value)
    }
    func getValueOp(value: Int)->String{
        return newoperation[value]
    }
    func getCountOperation() -> Int {
        return newoperation.count
    }
    
    //newCategory
    func addCategory(value: String){
        newcategory.append(value)
    }
    func getCategory(value: Int)->String{
        return newcategory[value]
    }
    func getCountCategory() -> Int {
        return newcategory.count
    }
    
    //Name
    func addName(value: String){
        operationName.append(value)
    }
    func getName(value: Int)->String{
        return operationName[value]
    }
    func getCountName() -> Int {
        return operationName.count
    }
    
    //Image
    func addImage(value: String){
        image.append(value)
    }
    func getImage(value: Int)->String{
        return image[value]
    }
    func getCountImage() -> Int {
        return image.count
    }
    
    //Date
    func addDate(value: Date){
        date.append(value)
    }
    func getDate(value: Int)->String{
        let selectedData : Date = date[value] as! Date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        let datetime = formatter.string(from: selectedData)
        
        return datetime
        
        //return date[value] as! Date
    }
    func getMonth(value: Date)->Bool{
        //Mese della data selezionata
        let selectedMonthData : Date = value
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "LLLL"
        let monthString = monthFormatter.string(from: selectedMonthData)
        
        //Mese di oggi
        let infoDate = Date()
        let f = DateFormatter()
        f.dateFormat = "LLLL"
        let todayMonth = f.string(from: infoDate)
        
        return monthString==todayMonth
    }
    func getCountDate() -> Int {
        return date.count
    }
    
    //EntryOperation
    func addEntryOperation(value: String){
        entryOperation.append(value)
    }
    func getEntryValueOp(value: Int)->String{
        return entryOperation[value]
    }
    func getEntryCountOperation() -> Int {
        return entryOperation.count
    }
    
    //EntryCategory
    func addEntryCategory(value: String){
        entryCategory.append(value)
    }
    func getEntryCategory(value: Int)->String{
        return entryCategory[value]
    }
    func getEntryCountCategory() -> Int {
        return entryCategory.count
    }
    
    //ExitOperation
    func addExitOperation(value: String){
        exitOperation.append(value)
    }
    func getExitValueOp(value: Int)->String{
        return exitOperation[value]
    }
    func getExitCountOperation() -> Int {
        return exitOperation.count
    }
    
    //ExitCategory
    func addExitCategory(value: String){
        exitCategory.append(value)
    }
    func getExitCategory(value: Int)->String{
        return exitCategory[value]
    }
    func getExitCountCategory() -> Int {
        return exitCategory.count
    }
    
    /*//Budget
    func reduceBudget(value: Int){
        budget = budget - value
    }
    //funzioni di controllo budget e attività mensile
    func startProgressBar() {
        for _ in 0...7 { //66
            self.progressValue += 0.015
        }
    }
    func resetProgressBar() {
        self.progressValue = 0.0
    }
    
    func reduceCircle() {
        self.progressCircle += 0.1
    }
    func resetCircle() {
        self.progressCircle = 0.0
    }*/
}
