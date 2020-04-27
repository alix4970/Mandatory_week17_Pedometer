//
//  ViewController.swift
//  StepTracker
//
//  Created by Ali Al sharefi on 27/04/2020.
//  Copyright © 2020 Ali Al sharefi. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var stepCount: UILabel!
    
    @IBOutlet weak var distanceCount: UILabel!
    
    @IBOutlet weak var paceCount: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton! //Pedometer for sensor dectection
    
    var isStarted = false // Keeping track of state
    
    let pedometer = CMPedometer() // Pedometer for detection
    override func viewDidLoad() {
        super.viewDidLoad()
        stepCount.text = "Steps: 0"
        distanceCount.text = "Distance: 0"
        paceCount.text = "Pace: 0"
        
        startStopButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        startStopButton.setTitle("Start your tracking!", for: .normal) //Initial text
    }
    
    
    @IBAction func trackingPressed(_ sender: Any) {
        if isStarted{
            startStopButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            startStopButton.setTitle("Start your tracking!", for: .normal)
            isStarted = false
            pedometer.stopUpdates()
        } else {
            startStopButton.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            startStopButton.setTitle("Stop your tracking!", for: .normal)
            
            isStarted = true
            
            pedometer.startUpdates(from: Date()) { (data, error) in
                DispatchQueue.main.async {
                    self.stepCount.text = "Steps: \(data?.numberOfSteps ?? 0.0)"
                    self.distanceCount.text = "Distance \(data?.distance?.intValue ?? 0) m"
                    self.paceCount.text = "Pace: \(((data?.currentPace?.doubleValue ?? 0.0) * 3.6).rounded()) km/t"
                }
            }
            
        }
    }

}

