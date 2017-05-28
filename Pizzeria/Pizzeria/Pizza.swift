//
//  Pizza.swift
//  Pizzeria
//
//  Created by Carlos on 28/05/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import Foundation

class Pizza{

    var tamanio: String {
        set(tamanio){
            self.tamanio = tamanio
        }
        
        get{
            return self.tamanio
        }
    
    }
    var masa: String {
    
        set(masa){
            self.masa = masa
        }
        
        get{
            return self.masa
        }
    
    }
    
    var queso: String {
        set(queso){
            self.queso = queso
        }
        
        get{
            return self.queso
        }
    
    }
    
    var ingredientes: String {
    
        set(ingredientes){
            self.ingredientes = ingredientes
        }
    
        get{
            return self.ingredientes
        }
    }

}
