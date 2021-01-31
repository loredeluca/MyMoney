//
//  SheetAddCard.swift
//  MyMoney
//
//  Created by Lorenzo De Luca on 28/01/2021.
//

import SwiftUI

struct Title: View {
    var body: some View {
        VStack{
        Text("Aggiungi carta")
            .font(.title)
            .fontWeight(.bold)
        Spacer().frame(height: 10)
        Text("Scegli nome e circuito della tua carta")
            .fontWeight(.light)
        }
    }
}
