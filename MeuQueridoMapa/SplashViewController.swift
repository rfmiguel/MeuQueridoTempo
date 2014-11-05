//
//  SplashViewController.swift
//  MeuQueridoTempo
//
//  Created by Rodrigo Miguel on 05/11/14.
//  Copyright (c) 2014 Usuário Convidado. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var ivSol: UIImageView!
    @IBOutlet weak var ivNuvem: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.ivSol.center = CGPointMake(self.ivSol.center.x+150, self.ivSol.center.y)
            }) { (completed) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.ivNuvem.image = UIImage(named: "nuvem_chuva_brava.png")
                    self.ivNuvem.center = CGPointMake(self.ivNuvem.center.x+150, self.ivNuvem.center.y)
                    self.performSegueWithIdentifier("splashsegue", sender:self)
                })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }


}
