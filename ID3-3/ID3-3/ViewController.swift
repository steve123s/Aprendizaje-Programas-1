//
//  ViewController.swift
//  ID3-3
//
//  Created by Daniel Salinas on 4/19/19.
//  Copyright © 2019 DanielSteven. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    enum Winner: String {
        case mexico = "México"
        case alemania = "Alemania"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let treesInForest = 1000
        var winners: [String: Int] = [Winner.mexico.rawValue: 0,
                                      Winner.alemania.rawValue: 0]
        
        for _ in 0..<treesInForest {
            if executeTree() == .mexico {
                winners.updateValue(winners[Winner.mexico.rawValue]!+1, forKey: Winner.mexico.rawValue)
            } else {
                winners.updateValue(winners[Winner.alemania.rawValue]!+1, forKey: Winner.alemania.rawValue)
            }
        }
        
        let greatestProbability = winners.max { a, b in a.value < b.value }
        
        print("Predicción: \(String(describing: greatestProbability!.key)) con una efectividad del \(String(describing: greatestProbability!.value*100/treesInForest))%")
        
    }
    
    private func executeTree() -> Winner {
        
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
        
        let answers = [
            "Hora?": "Tarde",
            "TipoJuego?": "Olímpicos",
            "CondicionesCancha?": "Buena",
            "Local?": "1",
            ]
        
        let decision = decisionTree.findAction(forAnswers: answers as [AnyHashable : NSObjectProtocol])
        
        if String(describing: decision!) == Winner.mexico.rawValue {
            return Winner.mexico
        } else {
            return Winner.alemania
        }
        
    }
    
}

