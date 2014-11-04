//
//  FavoritosTableViewController.swift
//  MeuQueridoMapa
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit
import CoreData

class FavoritosTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultController:NSFetchedResultsController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getFetchedResultController()
    }
    
    func getFetchedResultController() {
        let localDAO = LocaisDAO()
        self.fetchedResultController = localDAO.getNSFetchResultController()
        self.fetchedResultController!.performFetch(nil)
        self.fetchedResultController!.delegate = self
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultController!.fetchedObjects!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellId", forIndexPath: indexPath) as UITableViewCell
        let item = self.fetchedResultController!.fetchedObjects![indexPath.row] as Locais
        cell.textLabel.text = item.cidade
        cell.detailTextLabel?.text = item.temperatuma.description
        cell.imageView.image = UIImage(named: item.imagemClima)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let local:NSManagedObject = self.fetchedResultController?.objectAtIndexPath(indexPath) as NSManagedObject
            let localDAO:LocaisDAO = LocaisDAO()
            localDAO.delete(local)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
