//
//  ViewController.swift
//  issueTest
//
//  Created by AntonioStilo on 14/02/2019.
//  Copyright © 2019 com.stilo-studio. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animation: Animation?
    var timer = Timer()
    var isPlayRec = false
    var frameCount = 0
    var startDate: Date?
    var stepper: ImageStepperAnimator?
    let settings = RenderSettings()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func stop() {
        timer.invalidate()
        frameCount = 0
        animation?.randomize()
    }
    
    @IBAction func rec() {
        startDate = Date()
        frameCount = 0
        isPlayRec = false
        clearTempFolder()
        setTimer()
    }
    
    @IBAction func playRec() {
        startDate = Date()
        frameCount = 0
        isPlayRec = true
        clearTempFolder()
        setTimer()
        self.stepper = ImageStepperAnimator(renderSettings: settings)
        self.stepper?.render {
            
        }
        
    }
    
    @IBAction func play() {
        
        timer.invalidate()
        let activity = Activity()
        if isPlayRec {
            self.stepper?.videoWriter.closeReneder {
                activity.close()
                self.playVideo()
            }
            
        } else {
            
            let imageAnimator = ImageAnimator(renderSettings: settings)
            imageAnimator.render() {
                print("Video Rendered In one row")
                activity.close()
                self.playVideo()
            }
        }
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0/24.0, target: self, selector: #selector(self.animate), userInfo: nil, repeats: true)
    }
    
    @objc func animate() {
        
        animation?.animate()
        
        if isPlayRec {
            self.stepper?.appendPixelBuffer(image: (animation?.asImage())!, frameNum: frameCount)
        } else {
            let success = self.saveImage(image: (animation?.asImage())!, fileName: "frame_\(frameCount).png")
            if success == false {
                fatalError("save frame failed")
            }
        }
        
        self.title = self.getRecordTime(Date())
        frameCount += 1
    }
    
    private func saveImage(image: UIImage, fileName: String = "default.png") -> Bool {
        guard let data = image.pngData() else {
            return false
        }
        let directory =  URL(fileURLWithPath: NSTemporaryDirectory())
        do {
            let path = directory.appendingPathComponent(fileName)
            try data.write(to: path)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func clearTempFolder() {
        let fileManager = FileManager.default
        let tempFolderPath = NSTemporaryDirectory()
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: tempFolderPath + filePath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    private func playVideo() {
        let renderSettings = RenderSettings()
        let path = renderSettings.outputURL.path
        let player = AVPlayer(url: URL(fileURLWithPath: path!))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    private func getRecordTime(_ time: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "mm:ss"
        let value = Date(timeIntervalSince1970: time.timeIntervalSince1970 - startDate!.timeIntervalSince1970)
        return dateFormatterPrint.string(from: value)
    }

}

