//
//  EventsListViewController.swift
//  RemindMe
//
//  Created by Lalit Vinde on 17/03/24.
//

import UIKit
import EventKit
import SwiftUI
import Combine

class RemindersListViewController: UIView {
    let reminderManager = ReminderManager.shared
    var tableView: UITableView!
    var reminders: [EKReminder] = []
    let eventStore = EKEventStore()
    var updationListener : AnyCancellable?
    var scenePhaseObserver: NSObjectProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updationListener = reminderManager.$isUpdated.sink { [weak self]_ in
            self?.populateReminders()
        }
        scenePhaseObserver = NotificationCenter.default.addObserver(forName: UIScene.willEnterForegroundNotification, object: nil, queue: nil) { [weak self] _ in
                self?.populateReminders()
        }
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has no implementation")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.frame = bounds
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReminderTileTableViewCell.self, forCellReuseIdentifier: "CustomCell") // Register your custom cell class
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
                    tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    tableView.topAnchor.constraint(equalTo: topAnchor),
                    tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    tableView.widthAnchor.constraint(equalToConstant: CGFloat.greatestFiniteMagnitude),
                    tableView.heightAnchor.constraint(equalToConstant: CGFloat.greatestFiniteMagnitude)
                ])
        
        populateReminders()
    }
    
    func populateReminders(){
        Task {
            await reminderManager.fetchReminders { [weak self] reminders in
                if let reminders = reminders {
                    Task {
                        await MainActor.run {
                            self?.reminders = []
                            self?.reminders = reminders
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
}

extension RemindersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! ReminderTileTableViewCell
        cell.backgroundColor = .clear
        let reminder = reminders[indexPath.row]
        cell.reminder.title = reminder.title
        cell.reminder.notes = reminder.notes
        cell.reminder.dueDateComponents = reminder.dueDateComponents

        return cell
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy hh:mm a"
        return dateFormatter.string(from: date)
    }
}

extension RemindersListViewController: UITableViewDelegate {
    // Implement UITableViewDelegate methods here
}




class ReminderTileTableViewCell: UITableViewCell {
    let reminder = EKReminder(eventStore: ReminderManager.shared.eventStore)
    var hostViewController: UIHostingController<ReminderTile>?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has no implementation")
    }



    private func setupUI() {
        
        let defaultView = ReminderTile(model: reminder)
        hostViewController = UIHostingController(rootView: defaultView)

        // Embed the SwiftUI view
        if let hostView = hostViewController?.view {
            hostView.backgroundColor = .clear
            addSubview(hostView)
            hostView.translatesAutoresizingMaskIntoConstraints = false
            hostView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            hostView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            hostView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            hostView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            hostView.widthAnchor.constraint(equalToConstant: CGFloat.greatestFiniteMagnitude).isActive = true
            hostView.heightAnchor.constraint(equalToConstant: 80.w).isActive = true
        }
    }

   
}
