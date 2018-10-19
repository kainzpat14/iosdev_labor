//
//  PickerInterfaceController.swift
//  lab191018 WatchKit Extension
//
//  Created by Patrick Kainz and Patrick Papst on 19.10.18.
//  Copyright © 2018 Patrick Kainz and Patrick Papst. All rights reserved.
//

import WatchKit
import Foundation


class PickerInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let range = 0...999999;
        let pickerItems: [WKPickerItem] = range.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = String($0)+" km"
            pickerItem.title = String($0)
            return pickerItem
        }
        
        pickerKm.setItems(pickerItems);
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

    @IBOutlet weak var pickerKm: WKInterfacePicker!
}
