//
//  Entidad+CoreDataProperties.swift
//  prueba4
//
//  Created by Cristian Gaytan on 15/11/24.
//
//

import Foundation
import CoreData


extension Entidad {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entidad> {
        return NSFetchRequest<Entidad>(entityName: "Entidad")
    }

    @NSManaged public var nombres: String?
    @NSManaged public var apellidos: String?
    @NSManaged public var correo: String?
    @NSManaged public var contra: String?
    @NSManaged public var direccion: String?
    @NSManaged public var telefono: String?

}

extension Entidad : Identifiable {

}
