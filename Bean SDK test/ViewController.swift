//
//  ViewController.swift
//  Bean SDK test
//
//  Created by Tony Shu Zhang on 2017-03-22.
//  Copyright © 2017 Tony Shu Zhang. All rights reserved.
//

import UIKit
import Bean_iOS_OSX_SDK

class ViewController: UIViewController, PTDBeanManagerDelegate, PTDBeanDelegate {
   
    var beanManager: PTDBeanManager?
    var yourBean: PTDBean?
   
    @IBOutlet weak var ledTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        beanManager = PTDBeanManager()
        beanManager!.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startScanning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func beanManagerDidUpdateState(_ beanManager: PTDBeanManager!) {
        var scanError: NSError?
        
        if beanManager!.state == BeanManagerState.poweredOn {
            startScanning()
            
            if let e = scanError {
                print(e)
            } else {
                print("Please turn on your Bluetooth")
            }
        }
    }
    
    func startScanning() {
        var error: NSError?
        
        beanManager!.startScanning(forBeans_error: &error)
        if let e = error {
            print(e)
        }
    }
    
    func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!, error: Error!) {
        if let e = error {
            print(e)
        }
        
        print("Found a Bean: \(bean.name)")
        
        if bean.name == "Bean" {
            yourBean = bean
            print("got your bean")
            connectToBean(bean: yourBean!)
        }
    }
    
    
    func connectToBean(bean: PTDBean) {
        var error: NSError?
        
        beanManager?.connect(to: bean, withOptions: nil, error: &error)
        
        
    }
    
    
    @IBAction func pressMeButtonToToggleLED(_ sender: Any) {
        
        if ledTextLabel.text == nil {
            ledTextLabel.text = "LED: OFF"
        } else if ledTextLabel.text == "LED: OFF" {
            ledTextLabel.text = "LED: ON"
        } else {
            ledTextLabel.text = "LED: OFF"
        }
    }
    
    
    
    
}

