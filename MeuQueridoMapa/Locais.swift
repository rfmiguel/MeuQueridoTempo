//
//  Locais.swift
//  MeuQueridoTempo
//
//  Created by Rodrigo on 01/11/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import Foundation
import CoreData

class Locais: NSManagedObject {

    @NSManaged var cidade: String
    @NSManaged var descricaoClima: String
    @NSManaged var humidade: NSNumber
    @NSManaged var imagemClima: String
    @NSManaged var lat: NSNumber
    @NSManaged var long: NSNumber
    @NSManaged var temperatuma: NSNumber
    @NSManaged var tempMaxima: NSNumber
    @NSManaged var tempMinina: NSNumber

}
