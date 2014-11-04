//
//  LocaisDAO.swift
//  MeuQueridoTempo
//
//  Created by Usuário Convidado on 29/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit
import CoreData

struct LocaisDAO{
    static var managedObjectContext: NSManagedObjectContext?
    static var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    init() {
        self.setupCoreDataStack()
    }
    
    func setupCoreDataStack() {
        
        // Criação do modelo
        let modelURL:NSURL? = NSBundle.mainBundle().URLForResource("MapaModel", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOfURL: modelURL!)
        
        // Criação do coordenador
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let applicationDocumentsDirectory = urls[0] as NSURL
        
        let url = applicationDocumentsDirectory.URLByAppendingPathComponent("MapaModel.sqlite")
        var error: NSError? = nil
        
        var store = coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error)
        
        if store == nil {
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            return
        }
        if(LocaisDAO.managedObjectContext == nil){
            // Criação do contexto
            LocaisDAO.managedObjectContext = NSManagedObjectContext()
            LocaisDAO.managedObjectContext!.persistentStoreCoordinator = coordinator
        }
        
    }
    
    func getLocais()->Array<LocalVO> {
        var locaisArr:Array<LocalVO> = Array<LocalVO>()

        let fetchRequest = NSFetchRequest(entityName: "Locais")
        let sortDescriptor = NSSortDescriptor(key: "cidade", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        //Iniciamos a propriedade fetchedResultController com uma instância de NSFetchedResultsController
        //com o FetchRequest acima definido e sem opções de cache
        LocaisDAO.fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: LocaisDAO.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        //Executa o Fetch
        LocaisDAO.fetchedResultController.performFetch(nil)
        
        for local in LocaisDAO.fetchedResultController.fetchedObjects! as Array<Locais> {
            
            let localVO = LocalVO(cidade:local.cidade as String, lat:(local.lat as Double), long:(local.long as Double), imagemClima: (local.imagemClima as String), descricaoClima: (local.descricaoClima as String), temperatuma: (local.temperatuma as Double), tempMaxima: (local.tempMaxima as Double), tempMinina: (local.tempMinina as Double), humidade: (local.humidade as Double))
            locaisArr.append(localVO)
        }
        return locaisArr
    }
    
    func insert(localVO:LocalVO){
        let entityDescripition = NSEntityDescription.entityForName("Locais", inManagedObjectContext: LocaisDAO.managedObjectContext!)
        let local = Locais(entity: entityDescripition!, insertIntoManagedObjectContext: LocaisDAO.managedObjectContext)
        
        local.cidade = localVO.cidade!
        local.lat = localVO.lat!
        local.long = localVO.long!
        local.imagemClima = localVO.imagemClima
        local.descricaoClima = localVO.descricaoClima
        local.temperatuma = localVO.temperatuma!
        local.tempMaxima = localVO.tempMaxima!
        local.tempMinina = localVO.tempMinina!
        local.humidade = localVO.humidade!
        
        local.humidade = localVO.humidade!
        
        LocaisDAO.managedObjectContext?.save(nil)
    }
    
    func getNSFetchResultController()->NSFetchedResultsController{
        let fetchRequest = NSFetchRequest(entityName: "Locais")
        let sortDescriptor = NSSortDescriptor(key: "cidade", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: LocaisDAO.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
    }
    
}
