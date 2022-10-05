//
//
// Mano.swift
// JuegoSieteYMedia
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 05/10/22.
// Copyright (c) 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//


import Foundation

struct Mano {
    private var cartas: [Carta] = []
    
    var tamano: Int {
        cartas.count
    }
    
    mutating func addCarta(_ carta: Carta) {
        cartas.append(carta)
    }
    
    func getCarta() -> Carta? {
        guard let carta = self.cartas.first else { return nil }
        
        return carta
    }
    
    func sumarMano() -> Double {
        var suma: Double = 0.0
        cartas.forEach { carta in
            switch carta.numero {
            case 10, 11, 12 :
                suma += 0.5
            default:
                suma += Double(carta.numero)
            }
        }
        return suma
    }
}
