//
//  DetalheViewController.swift
//  MeuQueridoTempo
//
//  Created by Usuário Convidado on 29/10/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit

class DetalheViewController: UIViewController {

    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblMaxtemp: UILabel!
    @IBOutlet weak var lblMintemp: UILabel!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLong: UILabel!
    @IBOutlet weak var lblCidade: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var lblDescricao: UILabel!
    @IBOutlet weak var lblHumidade: UILabel!
    
    var local:Locais?
    var temperatura:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let temperauta:Int = Int(local!.temperatuma)
        let tempmin:Int = Int(local!.tempMinina)
        let tempmax:Int = Int(local!.tempMaxima)
        
        lblTemp.text = "\(temperauta)"
        lblMaxtemp.text = "\(tempmax)"
        lblMintemp.text = "\(tempmin)"
        lblLat.text = "\(local!.lat)"
        lblLong.text = "\(local!.long)"
        lblHumidade.text = "\(local!.humidade)"
        lblCidade.text = "\(local!.cidade)"
        lblDescricao.text = "\(local!.descricaoClima)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
