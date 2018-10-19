//
//  KeyboardInterfaceController.swift
//  lab191018 WatchKit Extension
//
//  Created by Patrick Kainz and Patrick Papst on 19.10.18.
//  Copyright © 2018 Patrick Kainz and Patrick Papst. All rights reserved.
//

import WatchKit
import Foundation


class KeyboardInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func on1() {
        addText(1);
    }
    
    @IBAction func on2() {
        addText(2);
    }
    
    @IBAction func on3() {
        addText(3);
    }
    
    @IBAction func on4() {
        addText(4);
    }
    
    @IBAction func on5() {
        addText(5);
    }
    
    @IBAction func on6() {
        addText(6);
    }
    
    @IBAction func on7() {
        addText(7);
    }
    
    @IBAction func on8() {
        addText(8);
    }
    
    @IBAction func on9() {
        addText(9);
    }
    
    @IBAction func on0() {
        addText(0);
    }
    
    func addText(_ num : Int8) {
        text = text + String(num);
        labelKm.setText(text + " km")
    }
    
    @IBAction func onBS() {
        if(text.count>1) {
            let index = text.index(text.endIndex,offsetBy: -2);
            text = String(text[...index]);            
            labelKm.setText(text + " km");
        } else {
            text="";
            labelKm.setText("0 km");
        }
    }
    
    @IBAction func onConfirm() {
        self.presentController(withName: "DoneInterfaceController", context: self)
    }
    
    func done() {
        dismiss();
    }
    
    @IBOutlet weak var labelKm: WKInterfaceLabel!
    
    var text : String = "";
}
