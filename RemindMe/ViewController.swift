//
//  ViewController.swift
//  RemindMe
//
//  Created by Lalit Vinde on 16/03/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UIActionSheetDelegate {
    let reminderManager = ReminderManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0xEEF0F5)
        
        let clockView = ClockUIView()
        
        let remindersListView = RemindersListViewController()
        
        let addButtonView = AddButtonUIView()
        addButtonView.addTarget(self, action: #selector(handleTap(_:)), for: .allTouchEvents)
        
        let stackView = UIStackView(arrangedSubviews: [clockView, remindersListView, addButtonView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if reminderManager.isGranted{
            // Create the view controller.
            let sheetViewController = ReminderSheetViewController()
            
            // Present it w/o any adjustments so it uses the default sheet presentation.
            present(sheetViewController, animated: true, completion: nil)
        }
        else{
            Task{
                await reminderManager.requestAuthorization()
            }
        }
       
    }
}


