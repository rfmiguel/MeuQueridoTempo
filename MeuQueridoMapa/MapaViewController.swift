//
//  ViewController.swift
//  MeuQueridoMapa
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapaViewController: UIViewController, MKMapViewDelegate, NSFetchedResultsControllerDelegate {

    var locationManager: CLLocationManager = CLLocationManager()
    var annotation: MapaItemAnnotation!
    var fetchedResultController:NSFetchedResultsController? = nil
    var locais:Array<LocalVO> = Array<LocalVO>()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        let testeLocal:CLLocationCoordinate2D  = CLLocationCoordinate2DMake(-23.550303,-46.634184)
        
        self.mapView.region = MKCoordinateRegionMakeWithDistance(testeLocal, 100000, 100000)
        self.mapView.delegate = self
        
        let localDAO = LocaisDAO()
        self.fetchedResultController = localDAO.getNSFetchResultController()
        self.fetchedResultController!.performFetch(nil)
        self.fetchedResultController?.delegate = self
        
        self.insertAnnotation()
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
            anView.image = UIImage(named:(annotation as MapaItemAnnotation).imagemClima )

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
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.insertAnnotation()
    }

    func insertAnnotation(){
        let localDAO = LocaisDAO()
        self.locais = localDAO.getLocais()
        
        for local in  self.locais{
            
            let cidade : String = local.cidade!
            let lat : Double = local.lat!
            let long : Double = local.long!
            let imagemClima : String = local.imagemClima
            let descricaoClima : String = local.descricaoClima
            let temperatuma : Double = local.temperatuma!
            let tempMaxima : Double = local.tempMaxima!
            let tempMinina : Double = local.tempMinina!
            let humidade : Double = local.humidade!
            
            let location:CLLocationCoordinate2D  = CLLocationCoordinate2DMake(lat,long)
            
            let annotation = MapaItemAnnotation(coordinate: location, title: cidade, subtitle: "" , lat: lat, long: long, imagemClima: imagemClima, descricaoClima: descricaoClima, temperatuma: temperatuma, tempMaxima: tempMaxima, tempMinina: tempMinina, humidade: humidade)
            
            self.mapView.addAnnotation(annotation)
            
        }
        
    }
}

