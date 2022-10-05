//
//
// Juego.swift
// JuegoSieteYMedia
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 05/10/22.
// Copyright (c) 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//


import Foundation

protocol JuegoDelegate {
    func cartaPedida(valor: Double, nombreImagen: String)
    func cartaPedidaCPU(valor: Double, nombreImagen: String)
    func acabarPartidaUsuario()
    func cambiaEstado(estado: EstadoJuego)
    
}

enum EstadoJuego {
    case turnoJugador, ganaJugador, pierdeJugador, empate, noIniciado, turnoCPU
}

class Juego {
    var delegate: JuegoDelegate?
    
    private var puntosParaGanar = 7.5
    
    var baraja : Baraja!
    var manoJugador : Mano!
    var estado : EstadoJuego {
        didSet {
            self.delegate?.cambiaEstado(estado: estado)
        }
    }
    
    
    init() {
        self.estado = EstadoJuego.noIniciado
    }
    
    func comenzarPartida() {
        self.baraja = Baraja()
        self.baraja.barajar()
        self.manoJugador = Mano()
        
        estado = .turnoJugador
    }
    
    func jugadorPideCarta() {
        if let pedida = self.baraja.repartirCarta() {
            self.manoJugador.addCarta(pedida)
            let valorMano = manoJugador.sumarMano()
            
            self.delegate?.cartaPedida(valor: valorMano, nombreImagen: pedida.nombreImagen)
            
            if (valorMano > puntosParaGanar) {
                estado = .pierdeJugador
            }
        }
    }
        
    func jugadorSePlanta() {
        estado = .turnoCPU
        jugarCPU()
    }
    
    // La CPU sacara el mismo numero de cartas para su jugada
    func jugarCPU() {
        
        
        var manoCPU = Mano()
        while ( !baraja.cartas.isEmpty ) {
            
            if let carta = self.baraja.repartirCarta() {
                manoCPU.addCarta(carta)
                
                self.delegate?.cartaPedidaCPU(valor: manoCPU.sumarMano(), nombreImagen: carta.nombreImagen)
                
                if manoCPU.sumarMano() < self.puntosParaGanar {
                    if Bool.random() {
                        self.acabarPartida(puntosCPU: manoCPU.sumarMano())
                        return
                    }
                } else {
                    self.acabarPartida(puntosCPU: manoCPU.sumarMano())
                    return
                }
            }
        }
        
        self.acabarPartida(puntosCPU: manoCPU.sumarMano())
    }
    
    private func acabarPartida(puntosCPU: Double) {
        
        if manoJugador.sumarMano() <= puntosParaGanar && puntosCPU <= puntosParaGanar {
            let diff = puntosParaGanar - manoJugador.sumarMano()
            let diffCPU = puntosParaGanar - puntosCPU
            
            if diff < diffCPU {
                estado = .ganaJugador
            } else if diff == diffCPU {
                estado = .empate
            } else {
                estado = .pierdeJugador
            }
        } else if puntosCPU >= puntosParaGanar {
            estado = .ganaJugador
        }
        
        print(estado)
        estado = .noIniciado
        
    }
    
} 
