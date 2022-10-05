//
//
// Baraja.swift
// JuegoSieteYMedia
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 05/10/22.
// Copyright (c) 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//


import Foundation

struct Baraja {
    var cartas: [Carta] = []
    
    init() {
        self.crearBaraja()
    }
    
    private mutating func crearBaraja() {
        for palo in [Palo.bastos, Palo.espadas, Palo.copas, Palo.oros] {
            for valor in 1...12 {
                if valor != 8 && valor != 9 {  //El 8 y el 9 no se suelen usar
                    //Aquí crearíais la nueva carta y la añadiríais al array "cartas"
                    cartas.append(Carta(numero: valor, palo: palo))
                }
            }
        }
    }
    
    mutating func repartirCarta() -> Carta? {
        guard let lastCarta = self.cartas.last else { return nil }
        self.cartas.removeLast()
        return lastCarta
    }
    
    mutating func barajar() {
        self.cartas.shuffle()
    }
}
