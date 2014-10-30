//
//  AddViewController.swift
//  MeuQueridoMapa
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    var climaRetorno:Array<Dictionary<String, AnyObject>>? = nil
    //var locais:Locais =
    
    
    @IBOutlet weak var lbCidade: UILabel!
    @IBOutlet weak var lbEstado: UILabel!
    @IBOutlet weak var lbPais: UILabel!
    
    @IBOutlet weak var txfLocal: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.buscaCidadeWs(textField.text)
        return true
    }
    
    func buscaCidadeWs(cidade:String)
    {
        let webservice:WebService = WebService()
        climaRetorno = webservice.getLocal(cidade)
        for climas in self.climaRetorno!
        {
            self.lbCidade.text = climas["name"]! as String
            let sys = climas["sys"]! as Dictionary<String,AnyObject>
            self.lbPais.text = sys["country"]! as String
            
//            locais.cidade = climas["name"]! as String
//            locais.lat =
//            locais.long =
//            @NSManaged var imagemClima: String
//            @NSManaged var descricaoClima: String
//            @NSManaged var temperatuma: NSDecimalNumber
//            @NSManaged var tempMaxima: NSDecimalNumber
//            @NSManaged var tempMinina: NSDecimalNumber
//            @NSManaged var humidade: NSNumber

            
        }
        
        
        
        txfLocal.resignFirstResponder()
        
    }

}
