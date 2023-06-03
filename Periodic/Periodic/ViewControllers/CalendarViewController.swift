//
//  CalendarViewController.swift
//  Periodic
//
//  Created by Aimeric on 4/9/23.
//

import Foundation
import UIKit
import SwiftUI

class CalendarViewController: UIViewController {
    private let periodLabel = UILabel()
    private let fertileLabel = UILabel()
    private let ovulationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the initial state of the calendar
        createCalendar()
        setUpLabel(periodLabel, "PERIOD")
        setUpLabel(periodLabel, "FERTILE")
        setUpLabel(periodLabel, "OVULATION")
        setUpConstraints()
    }
    private func setUpConstraints() {
        view.addSubview(periodLabel)
        NSLayoutConstraint.activate([
            periodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            periodLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -40),
            periodLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -40),
        ])
    }
    private func setUpLabel(_ label: UILabel, _ labelName: String) {
        label.text = labelName
        label.textColor = .black
        label.numberOfLines = 1
    }
    func createCalendar() {
           view.backgroundColor = .systemBackground
           let calendarView = UICalendarView()
           calendarView.translatesAutoresizingMaskIntoConstraints = false
           calendarView.calendar = .current
           calendarView.locale = .current
           calendarView.fontDesign = .rounded
           calendarView.delegate = self
           calendarView.layer.cornerRadius = 12
           calendarView.backgroundColor = .systemBackground
           calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
            let selection = UICalendarSelectionSingleDate(delegate: self)
           calendarView.selectionBehavior = selection
           view.addSubview(calendarView)
           NSLayoutConstraint.activate([
               calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
               calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
               calendarView.heightAnchor.constraint(equalToConstant: 430),
               calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
           ])
        }
   }

   extension CalendarViewController: UICalendarViewDelegate {
       func calendarView(_ calendarView: UICalendarView,
                         decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
           guard let day = dateComponents.day else {
               return nil
           }
           if !day.isMultiple(of: 2) {
               return UICalendarView.Decoration.default(color: .systemPink, size: .large)
           }
           if day.isMultiple(of: 10) {
               return UICalendarView.Decoration.default(color: .systemYellow, size: .large)
           }
           if day.distance(to: 29) <= 9 {
               return UICalendarView.Decoration.default(color: .systemCyan, size: .large)
           }
           return nil
       }
   }

   extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
       func dateSelection(_ selection: UICalendarSelectionSingleDate,
                          canSelectDate dateComponents: DateComponents?) -> Bool {
           return true
       }
       func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
           print(dateComponents as Any)
       }
}
