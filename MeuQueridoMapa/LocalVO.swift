//
//  LocalVO.swift
//  MeuQueridoTempo
//
//  Created by Usuário Convidado on 29/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit

class LocalVO: NSObject {
    var cidade: String?
    var lat: Double?
    var long: Double?
    var imagemClima: String
    var descricaoClima: String
    var temperatuma: Double?
    var tempMaxima: Double?
    var tempMinina: Double?
    var humidade: Double?
    
    init(cidade: String?, lat: Double?, long: Double?, imagemClima: String, descricaoClima: String, temperatuma: Double?, tempMaxima: Double?, tempMinina: Double?, humidade: Double?){
        self.cidade = cidade
        self.lat = lat
        self.long = long
        self.imagemClima = imagemClima
        self.descricaoClima = descricaoClima
        self.temperatuma = temperatuma
        self.tempMaxima = tempMaxima
        self.tempMinina = tempMinina
        self.humidade = humidade
    }
}
