import UIKit


class ReminderSheetViewController: UIViewController {
    let reminderManager = ReminderManager.shared
    let titleField: UITextField = UITextField()
    let notesTextArea: UITextView = UITextView()
    let datePicker: UIDatePicker = UIDatePicker()
    var addButton: SheetButtonUIView?
    var cancelButton: SheetButtonUIView?
    
    override func viewDidLoad() {
        dismiss(animated: true)
        super.viewDidLoad()
        if let presentationController = presentationController as? UISheetPresentationController {
                presentationController.detents = [
                    .medium()
                ]
            }
        view.backgroundColor = UIColor(hex: 0xEEF0F5)
        setupUI()
    }
    
    func setupUI() {
        // Create title field
        titleField.placeholder = "Enter Title"
        titleField.font = UIFont(name: "CascadiaCodePL-Regular", size: 16)
        titleField.layer.cornerRadius = 12.w
        titleField.backgroundColor =  UIColor(hex: 0xE4E7ED)
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.heightAnchor.constraint(equalToConstant: 55.w).isActive = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10.w, height: titleField.frame.height))
        titleField.leftView = paddingView
        titleField.leftViewMode = .always
        
        // Create notes text area
        notesTextArea.text = "Enter Notes"
        notesTextArea.textColor = UIColor.lightGray
        notesTextArea.font = UIFont(name: "CascadiaCodePL-Regular", size: 16)
        notesTextArea.backgroundColor =  UIColor(hex: 0xE4E7ED)
        notesTextArea.layer.cornerRadius = 12.w
        notesTextArea.delegate = self
        notesTextArea.translatesAutoresizingMaskIntoConstraints = false
        notesTextArea.heightAnchor.constraint(equalToConstant: 150.w).isActive = true
        notesTextArea.textContainerInset = UIEdgeInsets(top: 15.w, left: 10.w, bottom: 4.w, right: 4.w)
        
        
        //Date & Time picker
        datePicker.datePickerMode = .dateAndTime
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        addButton = SheetButtonUIView(text: "Add") {[weak self] in
            Task{[weak self] in
                if let self{
                    if await self.reminderManager.setReminder(date: self.datePicker.date, title: self.titleField.text, notes: self.notesTextArea.text){
                        self.dismiss(animated: true)
                    }
                }
                
            }
        }
        cancelButton = SheetButtonUIView(text: "Cancel") {[weak self] in
            self?.dismiss(animated: true)
        }
        
        //[Add] [Cancel]
        let hStack = UIStackView(arrangedSubviews: [cancelButton!, addButton!])
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        
        // Create vertical stack view
        let stackView = UIStackView(arrangedSubviews: [titleField, notesTextArea, datePicker, hStack])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10.w
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add stack view to the view hierarchy
        view.addSubview(stackView)
        
        // Set constraints for stack view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func addButtonTapped() {
    }
}
extension ReminderSheetViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if notesTextArea.textColor == UIColor.lightGray {
            notesTextArea.text = nil
            notesTextArea.textColor = UIColor.black
        }
    }
   
}
