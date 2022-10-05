//
//
// Carta.swift
// JuegoSieteYMedia
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 05/10/22.
// Copyright (c) 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//


import Foundation

struct Carta {
    let numero: Int
    let palo: Palo
    
    var descripcion: String {
        return "El \(numero) de \(palo.rawValue)"
    }
                
    var nombreImagen: String {
        return "\(numero)\(palo.rawValue)"
    }
}

enum Palo: String {
    case bastos = "bastos"
    case espadas = "espadas"
    case copas = "copas"
    case oros = "oros"
    
}

