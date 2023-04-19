//
//  ViewController.swift
//  Periodic
//
//  Created by Aimeric on 4/9/23.
//

import UIKit

class PeriodViewController: UIViewController {
    var manager = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemMint
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(circleProgressView)
    }
    func addContraints() {
        NSLayoutConstraint.activate([
            circleProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    private var circleProgressView: UIView {
        let circleView = UIView()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.width / 2, y: 100), radius: 50, startAngle: -.pi/2, endAngle: 2 * .pi, clockwise: true)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 10
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.strokeEnd = 1
        circleView.layer.addSublayer(circleLayer)
        circleView.layer.opacity = 0.4
        circleView.translatesAutoresizingMaskIntoConstraints = false

        
//        NSLayoutConstraint.activate([
//            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
        
        //        if manager.untilOvulationDays != nil {
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: view.frame.width / 2, y: 100), radius: 50, startAngle: -.pi/2, endAngle: 2 * .pi * CGFloat(1.4242) - .pi/2, clockwise: true)
        let progressLayer = CAShapeLayer()
        progressLayer.path = progressPath.cgPath
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.lineWidth = 10
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 1
        circleView.layer.addSublayer(progressLayer)
        
        let ovulationLabel = UILabel()
        ovulationLabel.text = "OVULATION"

        //            ovulationLabel.text = "OVULATION\(manager.untilOvulationDays! <= 0 ? "" : " IN")"
        ovulationLabel.font = UIFont.systemFont(ofSize: 12)
        ovulationLabel.textColor = UIColor.white
        circleView.addSubview(ovulationLabel)
        ovulationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ovulationLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor, constant: 100),
            ovulationLabel.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 150)
        ])
        
        let daysLabel = UILabel()
        daysLabel.text = "DAYS"

        //            daysLabel.text = "\(manager.untilOvulationDays!) DAYS".formattedDays
        daysLabel.font = UIFont.boldSystemFont(ofSize: 40)
        daysLabel.textColor = UIColor.white
        circleView.addSubview(daysLabel)
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor, constant: 250),
            daysLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: 250),
        ])
        
        let separator = UIView()
        separator.backgroundColor = UIColor.white
        circleView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: -20),
            separator.topAnchor.constraint(equalTo: daysLabel.bottomAnchor, constant: 10)
        ])
        
        let chanceLabel = UILabel()
        chanceLabel.text = "chance\nof getting pregnant"

        //            chanceLabel.text = "\(manager.pregnancyChance) chance\nof getting pregnant"
        chanceLabel.font = UIFont.systemFont(ofSize: 14)
        chanceLabel.textColor = UIColor.white
        chanceLabel.numberOfLines = 2
        chanceLabel.textAlignment = .center
        circleView.addSubview(chanceLabel)
        chanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chanceLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            chanceLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
        ])
        let tapLabel = UILabel()
        tapLabel.text = "Tap the"
        tapLabel.font = UIFont.systemFont(ofSize: 14)
        tapLabel.textColor = UIColor.white
        
        return circleView
    }
//        } else {
//        }
//    }
}
