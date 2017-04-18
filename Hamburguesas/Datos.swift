//
//  Datos.swift
//  Hamburguesas
//
//  Created by Carlos on 17/04/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import Foundation
import UIKit

class ColeccionDePaises{

    let paises = ["Mexio","USA","España","Inglaterra","Canada","Rusia","Ecuador","Colombia","Brazil","Chile","Peru","Argentina","Alemania","Italia","Portugal","China","Japon","India","Australia"]
    
    func obtenPais() -> String {
        let pais = Int (arc4random()) % paises.count
        return paises[pais]
    }
    
}

class ColeccionDeHamburguesas{

    let hamburguesas = ["Mexicana Picante","US BBQ","Mediterranea","Potato Burguer","Bear Burguer","PolskyBurguer","Ecuatorian Hamburguer","Medellin Especial","Samba Burguer","Patagonias Burguer","Machu Pichu Especial","La vaca Burguer","Munchen Burguer","Pasta Burguer","Porto Burguer","Shangai Dragon","Sake Burguer","TajMajal Special","Cangary Burguer"]
    
    func obtenHamburguesa() -> String {
        let hamburguesa = Int(arc4random()) % hamburguesas.count
        return hamburguesas[hamburguesa]
    }
    
}

struct Colores {
    
    let colores = [ UIColor(red:210/255.0, green: 90/255.0, blue: 45/255.0, alpha: 1),
                    UIColor(red:40/255.0, green: 170/255.0, blue: 45/255.0, alpha: 1),
                    UIColor(red:3/255.0, green: 180/255.0, blue: 90/255.0, alpha: 1),
                    UIColor(red:210/255.0, green: 190/255.0, blue: 5/255.0, alpha: 1),
                    UIColor(red:120/255.0, green: 120/255.0, blue: 50/255.0, alpha: 1),
                    UIColor(red:130/255.0, green: 80/255.0, blue: 90/255.0, alpha: 1),
                    UIColor(red:130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1),
                    UIColor(red:3/255.0, green: 50/255.0, blue: 90/255.0, alpha: 1)]
    
    func getColorAleatorio() -> UIColor {
        let posicion = Int (arc4random()) % colores.count
        return colores[posicion]
    }
    
}
