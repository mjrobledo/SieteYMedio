//
//
// ViewController.swift
// JuegoSieteYMedia
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 05/10/22.
// Copyright (c) 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lblPuntos: UILabel!
    @IBOutlet weak var lblPuntosCPU: UILabel!
    
    @IBOutlet weak var btnNueva: UIButton!
    @IBOutlet weak var btnParar: UIButton!
    
    
    @IBOutlet weak var viewCPU: UIView!
    @IBOutlet weak var viewPlayer: UIView!
    
    let juego = Juego()
    var vistasCartas : [UIImageView] = []
    var posicionCartas: Int = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnParar.setTitle("-", for: .disabled)
        btnParar.setTitle(TextApp.Parar, for: .normal)
        
        
        
        juego.delegate = self
        
        btnNueva.isEnabled = false
        btnParar.isEnabled = false
    }

    @IBAction func iniciarJuego(_ sender: Any) {
        _ = vistasCartas.map( { $0.removeFromSuperview() })
        posicionCartas = 1
        
        lblPuntos.text = "0.0"
        lblPuntosCPU.text = "0.0"
        
        juego.comenzarPartida()
        juego.jugadorPideCarta()
    }
        
    @IBAction func nuevaCarta(_ sender: Any) {
        self.pedirCartaJugador()
    }
    
    private func pedirCartaJugador() {
        juego.jugadorPideCarta()
    }
    
    @IBAction func parar(_ sender: Any) {
        juego.jugadorSePlanta()
    }
    
}


extension ViewController: JuegoDelegate {
    func cartaPedida(valor: Double, nombreImagen: String) {
        lblPuntos.text = valor.description
        self.dibujarCarta(imagen: nombreImagen, posicion: posicionCartas, viewCartas: viewPlayer)
        posicionCartas += 1
    }
    
    func cartaPedidaCPU(valor: Double, nombreImagen: String) {
        lblPuntosCPU.text = valor.description
        self.dibujarCarta(imagen: nombreImagen, posicion: posicionCartas, viewCartas: viewCPU)
        posicionCartas += 1
    }
    
    func acabarPartidaUsuario() {
        posicionCartas = 1
    }  
    
    func cambiaEstado(estado: EstadoJuego) {
        switch estado {
        case .turnoJugador:
            btnParar.isEnabled = true
            btnNueva.isEnabled = true
        case .ganaJugador:
            btnParar.isEnabled = false
            btnNueva.isEnabled = false
            self.showAlert(message: TextApp.HasGanado)
            posicionCartas = 1
        case .pierdeJugador:
            btnParar.isEnabled = false
            btnNueva.isEnabled = false
            self.showAlert(message: TextApp.HasPerdido)
            posicionCartas = 1
        case .empate:
            btnParar.isEnabled = false
            btnNueva.isEnabled = false
            self.showAlert(message: TextApp.HasEmpatado)
            posicionCartas = 1
        case .noIniciado:
            
            posicionCartas = 1
            
        case .turnoCPU:
            btnParar.isEnabled = false
            btnNueva.isEnabled = false
            posicionCartas = 1
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(
            title: TextApp.FinDelJuego,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: TextApp.OK,
            style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension ViewController {
    
    func dibujarCarta(imagen: String, posicion: Int, viewCartas: UIView ) {
        let nombreImagen = imagen
        
        let imagenCarta = UIImage(named: nombreImagen)
        
        let cartaView = UIImageView(image: imagenCarta)
        cartaView.frame = btnNueva.frame
        
        cartaView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        
        cartaView.backgroundColor = .gray
        cartaView.layer.borderWidth = 1
        cartaView.layer.borderColor = UIColor.black.cgColor
        viewCartas.addSubview(cartaView)
        
        self.vistasCartas.append(cartaView)
        
        UIView.animate(withDuration: 0.5){ [self] in
        
            cartaView.frame = CGRect(x: 0 + CGFloat(btnNueva.frame.width-100)  * CGFloat((posicion-1)),
                                     y: 0,
                                     width: btnNueva.frame.width,
                                     height: btnNueva.frame.height)
        
            cartaView.transform = CGAffineTransform(rotationAngle:0);
        }
    }
    
}
