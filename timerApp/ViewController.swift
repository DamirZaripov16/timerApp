//
//  ViewController.swift
//  timer
//
//  Created by Damirka on 14.10.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!

    // MARK: - Properties
    
    private var counter: Int = 0
    private lazy var timer: Timer = Timer()
    
    var isFirstLaunch: Bool = true

    // MARK: - IBActions
    
    @IBAction func didTapStartButton(_ sender: Any) {
        activateTimer(isActive: true)
    }

    @IBAction func didTapStopButton(_ sender: Any) {
        activateTimer(isActive: false)
    }
    
    // MARK: - Selectors
    
    @objc
    private func incrementCounter() {
        counter += 1
        let time = secondsToMinutesSeconds(seconds: counter)
        timerLabel.text = makeTimeString(minutes: time.minutes, seconds: time.seconds)
    }
    
    // MARK: - Public methods
    
    func activateTimer(isActive: Bool) {
        if isActive {
            timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(incrementCounter),
                userInfo: nil,
                repeats: true
            )
            RunLoop.current.add(timer, forMode: .default)
        } else {
            timer.invalidate()
        }
        
        startButton.isEnabled = !isActive
    }

    // MARK: - Private methods
    
    private func secondsToMinutesSeconds(seconds: Int) -> (minutes: Int, seconds: Int) {
        (seconds / 60, seconds % 60)
    }

    private func makeTimeString(minutes: Int, seconds: Int) -> String {
        var timeString = String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}
