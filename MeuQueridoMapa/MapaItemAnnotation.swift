//
//  MapaItemAnnotation.swift
//  MeuQueridoTempo
//
//  Created by Usuário Convidado on 29/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit
import MapKit

class MapaItemAnnotation: NSObject, MKAnnotation  {
   
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    var lat: Double
    var long: Double
    var imagemClima: String
    var descricaoClima: String
    var temperatuma: Double
    var tempMaxima: Double
    var tempMinina: Double
    var humidade: Double
    //var mapItem: MKMapItem
    var imageName = UIImage(named: "annotation")
    var index: Int
    
    init(
        coordinate: CLLocationCoordinate2D,
        title: String,
        subtitle: String,
        lat: Double,
        long: Double,
        imagemClima: String,
        descricaoClima: String,
        temperatuma: Double,
        tempMaxima: Double,
        tempMinina:  Double,
        humidade: Double,
        index: Int
        /*mapItem: MKMapItem*/) {
            
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.lat = lat
        self.long = long
        self.imagemClima = imagemClima
        self.descricaoClima = descricaoClima
        self.temperatuma = temperatuma
        self.tempMaxima = tempMaxima
        self.tempMinina = tempMinina
        self.humidade = humidade
        self.index = index
      //  self.mapItem = mapItem
    }

    
}

