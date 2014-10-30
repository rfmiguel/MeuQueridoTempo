//
//  ViewController.swift
//  MeuQueridoMapa
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, MKMapViewDelegate {

    var locationManager: CLLocationManager = CLLocationManager()
    
    var annotation: MapaItemAnnotation!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        let testeLocal:CLLocationCoordinate2D  = CLLocationCoordinate2DMake(-23.550303,-46.634184)
        
        self.mapView.region = MKCoordinateRegionMakeWithDistance(testeLocal, 8000, 8000)
        self.mapView.delegate = self
        
       /* for localis in  {
            
            var cidade : String = (localis as Locais).cidade
            var lat : Double = (localis as Locais).lat
            var long : Double = (localis as Locais).long
            var imagemClima : String = (localis as Locais).imagemClima
            var descricaoClima : String = (localis as Locais).descricaoClima
            var temperatuma : NSDecimalNumber = (localis as Locais).temperatuma
            var tempMaxima : NSDecimalNumber = (localis as Locais).tempMaxima
            var tempMinina : NSDecimalNumber = (localis as Locais).tempMinina
            var humidade : NSNumber = (localis as Locais).humidade
            
            var location:CLLocationCoordinate2D  = CLLocationCoordinate2DMake(lat,long)
            
            var annotation = MapaItemAnnotation(coordinate: location, title: cidade, subtitle: "" , lat: lat, long: long, imagemClima: imagemClima, descricaoClima: descricaoClima, temperatuma: temperatuma, tempMaxima: tempMaxima, tempMinina: tempMinina, humidade: humidade)
            
            self.mapView.addAnnotation(annotation)
            
        }*/
        
        //criar anotaçao customizada para a FIAP
        self.annotation = MapaItemAnnotation(coordinate: testeLocal, title: "FIAP", subtitle: "Faculdade Tecnologia", lat: -23.550303, long: -46.634184, imagemClima: "01d", descricaoClima: "", temperatuma: 12, tempMaxima: 12, tempMinina: 20, humidade: 50)
        
         self.mapView.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        //verificar se a marcação já existe para tentar reutilizá-la
        if annotation is MapaItemAnnotation {
            let reuseId = "mapaAnnot"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            //se a view não existir
            if anView == nil {
                //criar a view como subclasse de MKAnnotationView
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            }
            
            //add pin
            anView.image = UIImage(named:"01d")

            //permitir que mostre o "balão" com informações da marcação
            anView.canShowCallout = true
            
            //adiciona um botão do lado direito do balão para futuro 'tap'
            anView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
            
            return anView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        self.performSegueWithIdentifier("Detalhes", sender: (view.annotation as MapaItemAnnotation))
    }

}

