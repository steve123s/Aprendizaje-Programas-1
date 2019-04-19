//
//  ViewController.swift
//  ID3-2
//
//  Created by Daniel Salinas on 4/18/19.
//  Copyright © 2019 DanielSteven. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        executeTree()
        
    }

    private func executeTree() {
        
        let attributes = [ "Hora?", "TipoJuego?", "CondicionesCancha?", "Local?" ]
        let examples = [
            // Each sub-array has a value for each attribute:
            [ "Mañana", "Mundial", "Excelente", "1" ],
            [ "Tarde", "Olímpicos", "Buena", "1" ],
            [ "Noche", "Amistoso", "Mala", "0" ],
            [ "Tarde", "Amistoso", "Pésima", "0" ],
            [ "Tarde", "Olímpicos", "Excelente", "1" ],
            [ "Tarde", "Olímpicos", "Mala", "1" ],
            [ "Tarde", "Olímpicos", "Mala", "1" ],
            [ "Mañana", "Mundial", "Excelente", "1" ],
            [ "Tarde", "Olímpicos", "Buena", "0" ],
            [ "Noche", "Amistoso", "Mala", "0" ],
            [ "Noche", "Mundial", "Pésima", "1" ],
            [ "Tarde", "Mundial", "Excelente", "1" ],
            [ "Tarde", "Olímpicos", "Mala", "1" ]
            ]
        let actions = [ // One for each entry in the examples array
            "Alemania",
            "Alemania",
            "Alemania",
            "México",
            "Alemania",
            "Alemania",
            "Alemania",
            "Alemania",
            "México",
            "Alemania",
            "México",
            "Alemania",
            "Alemania",
            ]
        
        // Multiple type casts required to convert to collections of NSObjectProtocol in Swift
        let decisionTree = GKDecisionTree(examples: examples as NSArray as! [[NSObjectProtocol]],
                                          actions: actions as NSArray as! [NSObjectProtocol],
                                          attributes: attributes as NSArray as! [NSObjectProtocol])
        
        print(decisionTree.description)
        
        let answers = [
            "Hora?": "Tarde",
            "TipoJuego?": "Olímpicos",
            "CondicionesCancha?": "Buena",
            "Local?": "1",
            ]
        
        let decision = decisionTree.findAction(forAnswers: answers as [AnyHashable : NSObjectProtocol])
        
        print("Predicción: \(decision!)")
    }

}

