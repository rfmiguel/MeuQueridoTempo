//
//  AddViewController.swift
//  MeuQueridoMapa
//
//  Created by Usuário Convidado on 27/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    var localVO:LocalVO? = nil
    
    
    @IBOutlet weak var lbLoading: UILabel!
    @IBOutlet weak var acLoading: UIActivityIndicatorView!
    @IBOutlet weak var lbCidade: UILabel!
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
    
        println(self.lbLoading.text)
        txfLocal.resignFirstResponder()
        self.buscaCidadeWs(textField.text)
        
        return true
    }
    
    func buscaCidadeWs(cidade:String)
    {
        
        self.acLoading.startAnimating()
        self.lbLoading.text = "Carregando"
        
        
        let webservice:WebService = WebService()
        webservice.getLocal(cidade, callBack: { (retorno) -> Void in
     
            for climas in retorno
            {
                self.lbCidade.text = climas["name"]! as? String
                let sys = climas["sys"]! as Dictionary<String,AnyObject>
                self.lbPais.text = sys["country"]! as? String
                
                let cidade = climas["name"]! as String
                let coord = climas["coord"]! as Dictionary<String,AnyObject>
                let lat = coord["lat"]! as Double
                let long = coord["lon"]! as Double
                let tempo = (climas["weather"]! as Array<Dictionary<String,AnyObject>>)[0]
                let imagemClima = tempo["icon"]! as String
                let descricao = tempo["description"]! as String
                let dadosTemperatura = climas["main"]! as Dictionary<String,AnyObject>
                let temperatura = dadosTemperatura["temp"]! as Double
                let temperaturaMaxima = dadosTemperatura["temp"]! as Double
                let temperaturaMinima = dadosTemperatura["temp"]! as Double
                let humidade = dadosTemperatura["temp"]! as Double
                
                self.localVO = LocalVO(cidade: cidade, lat: lat, long: long, imagemClima: imagemClima, descricaoClima: descricao, temperatuma: temperatura, tempMaxima: temperaturaMaxima, tempMinina: temperaturaMinima, humidade: humidade)
                
            }
            self.lbLoading.text = ""
            self.acLoading.stopAnimating()
                
          
        })
        
    }

    @IBAction func clickBtConfirma(sender: UIButton) {
        if(localVO != nil){
            let localDAO = LocaisDAO()
            localDAO.insert(localVO!)
            self.sair()
        }
        
    }
    
    @IBAction func clickBtCancela(sender: UIButton) {
        self.sair()
    }
    
    private func sair(){
        navigationController?.popViewControllerAnimated(true)
    }
    
}
