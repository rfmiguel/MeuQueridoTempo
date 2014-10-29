//
//  Locais.swift
//  MeuQueridoMapa
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import Foundation
import CoreData

class Locais: NSManagedObject {

    @NSManaged var cidade: String
    @NSManaged var lat: NSNumber
    @NSManaged var long: NSNumber
    @NSManaged var imagemClima: String
    @NSManaged var descricaoClima: String
    @NSManaged var temperatuma: NSDecimalNumber
    @NSManaged var tempMaxima: NSDecimalNumber
    @NSManaged var tempMinina: NSDecimalNumber
    @NSManaged var humidade: NSNumber

}
