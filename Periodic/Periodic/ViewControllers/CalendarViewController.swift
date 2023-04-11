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
    
    private let calendarView = UICalendarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the initial state of the calendar
        createCalendar()
    }
    
    func createCalendar() {
           view.backgroundColor = .systemPink
           
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
               calendarView.heightAnchor.constraint(equalToConstant: 400),
               calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
           ])
       }
   }

   extension CalendarViewController: UICalendarViewDelegate {
       func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
           
           guard let day = dateComponents.day else {
               return nil
           }
           
           if !day.isMultiple(of: 2) {
               return UICalendarView.Decoration.default(color: .systemPink, size: .large)
           }
           
           return nil
       }
       
       
   }

   extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
       
       func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
           return true
       }
       
       
       func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
           print(dateComponents)
       }
}
