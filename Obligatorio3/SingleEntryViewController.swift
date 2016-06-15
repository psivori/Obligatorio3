//
//  SingleEntryViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 10/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit

class SingleEntryViewController: UIViewController {
    
    var entry: Entry?
    @IBOutlet weak var entryTitle: UILabel!
    @IBOutlet weak var entryOrigin: UILabel!
    @IBOutlet weak var entryDate: UILabel!
    @IBOutlet weak var entryDestination: UILabel!
    @IBOutlet weak var entryDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryTitle.text = entry?.title
        entryOrigin.text = entry?.origin
        entryDestination.text = entry?.destination
        entryDate.text = entry?.date
        entryDescription.text = entry?.description
    }

}
