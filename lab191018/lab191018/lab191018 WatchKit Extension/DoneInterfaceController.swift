//
//  DoneInterfaceController.swift
//  lab191018 WatchKit Extension
//
//  Created by Patrick Kainz and Patrick Papst on 19.10.18.
//  Copyright © 2018 Patrick Kainz and Patrick Papst. All rights reserved.
//

import WatchKit
import Foundation


class DoneInterfaceController: WKInterfaceController {

    var delegate: KeyboardInterfaceController?;
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        delegate = context as? KeyboardInterfaceController
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

    @IBAction func onClose() {
        dismiss()
        self.delegate?.done();
    }
}
