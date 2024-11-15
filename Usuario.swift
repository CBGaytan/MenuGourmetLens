//
//  Usuario.swift
//  prueba4
//
//  Created by Cristian Gaytan on 15/11/24.
//
//

import Foundation
import SwiftData


@Model public class Usuario {
    var id: Int16? = 0
    var nombres: String?
    var apellidos: String?
    var correo: String?
    var contra: String?
    var direccion: String?
    var telefono: String?
    public init() {

    }
    
}
