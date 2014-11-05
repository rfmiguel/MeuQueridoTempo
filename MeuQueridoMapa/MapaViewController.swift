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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "detailTosegueMap") {
            let detalheViewController:DetalheViewController = segue.destinationViewController as DetalheViewController
        }else{
            var vc:AddViewController = segue.destinationViewController as AddViewController
        }
        
        
        //let detalheViewController:DetalheViewController = segue.destinationViewController as DetalheViewController
       // var index =  mapView.indexOfAccessibilityElement(sender);
      //  detalheViewController.local = self.fetchedResultController!.fetchedObjects![index] as Locais
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        self.performSegueWithIdentifier("detailTosegueMap", sender: (view.annotation as MapaItemAnnotation))
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.insertAnnotation()
        self.ajustaRegionMapa()
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
            region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.3;
            region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.3;
            region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.2;
            region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.2;
        
            self.mapView.regionThatFits(region);
            self.mapView.setRegion(region, animated: true);
        }else{
            
        }
    }
}