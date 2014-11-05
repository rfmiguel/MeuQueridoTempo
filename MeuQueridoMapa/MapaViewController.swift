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
        
        self.mapView.delegate = self
        
        let localDAO = LocaisDAO()
        self.fetchedResultController = localDAO.getNSFetchResultController()
        self.fetchedResultController!.performFetch(nil)
        self.fetchedResultController?.delegate = self
        
        self.insertAnnotation()
        
         self.mapView.addAnnotation(annotation)
        
        self.ajustaRegionMapa()
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
        self.performSegueWithIdentifier("detailTosegue", sender: (view.annotation as MapaItemAnnotation))
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.insertAnnotation()
        self.ajustaRegionMapa()
    }

    func insertAnnotation(){
        let localDAO = LocaisDAO()
        self.locais = localDAO.getLocais()
        let arrLocais = self.locais as Array<LocalVO>

        for(var i:Int = 0; i < arrLocais.count;i++){
            let cidade : String = arrLocais[i].cidade!
            let lat : Double = arrLocais[i].lat!
            let long : Double = arrLocais[i].long!
            let imagemClima : String = arrLocais[i].imagemClima
            let descricaoClima : String = arrLocais[i].descricaoClima
            let temperatuma : Double = arrLocais[i].temperatuma!
            let tempMaxima : Double = arrLocais[i].tempMaxima!
            let tempMinina : Double = arrLocais[i].tempMinina!
            let humidade : Double = arrLocais[i].humidade!
            
            let location:CLLocationCoordinate2D  = CLLocationCoordinate2DMake(lat,long)
            
            let annotation = MapaItemAnnotation(coordinate: location, title: cidade, subtitle: "" , lat: lat, long: long, imagemClima: imagemClima, descricaoClima: descricaoClima, temperatuma: temperatuma, tempMaxima: tempMaxima, tempMinina: tempMinina, humidade: humidade, index: i)
            
            self.mapView.addAnnotation(annotation)
            
        }
        
    }

    func ajustaRegionMapa(){
        if(self.mapView.annotations.count > 0){
            var topLeftCoord:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0);
            topLeftCoord.latitude = -90;
            topLeftCoord.longitude = 180;
        
            var bottomRightCoord:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0);
            bottomRightCoord.latitude = 90;
            bottomRightCoord.longitude = -180;
        
            for anotation in self.mapView.annotations{
                topLeftCoord.longitude = fmin(topLeftCoord.longitude, anotation.coordinate.longitude);
                topLeftCoord.latitude = fmax(topLeftCoord.latitude, anotation.coordinate.latitude);
            
                bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, anotation.coordinate.longitude);
                bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, anotation.coordinate.latitude);
            }
        
            var region:MKCoordinateRegion = MKCoordinateRegion(center: topLeftCoord, span:MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0));
            region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
            region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
            region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.3;
            region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.3;
        
            self.mapView.regionThatFits(region);
            self.mapView.setRegion(region, animated: true);
        }else{
            
        }
    }
}