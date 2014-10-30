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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
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
            anView.image = UIImage(named:"favPin")
            //}else{
                //add pin
            //    anView.image = UIImage(named:"simplePin")
           // }
            //permitir que mostre o "balão" com informações da marcação
            anView.canShowCallout = true
            
            //adiciona um botão do lado direito do balão para futuro 'tap'
            anView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
            
            return anView
        }
        return nil
    }

    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        self.performSegueWithIdentifier("detalhes", sender: (view.annotation as MapaItemAnnotation))
    }

}

