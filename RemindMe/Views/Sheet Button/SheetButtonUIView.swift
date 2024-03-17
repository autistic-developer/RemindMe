import UIKit
import SwiftUI

@IBDesignable
class SheetButtonUIView: UIControl {
    
    let text: String
    let onTap: () -> ()
    private var hostingController: UIHostingController<SheetButtonView>?
    required init(text: String, onTap: @escaping () -> ()) {
            self.text = text
            self.onTap = onTap
            super.init(frame: .zero) 
    }
    override init(frame: CGRect) {
        text = ""
        onTap = {}
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        text = ""
        onTap = {}
        super.init(coder: coder)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard hostingController == nil else { return }
        
        
        
        let sheetButtonView = SheetButtonView(text: text, onTab: onTap)
        hostingController = UIHostingController(rootView: sheetButtonView)
        
        guard let embeddedAddButtonView = hostingController?.view else { return }
        
        embeddedAddButtonView.backgroundColor = .clear
        embeddedAddButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(embeddedAddButtonView)
        
        NSLayoutConstraint.activate([
            embeddedAddButtonView.topAnchor.constraint(equalTo: topAnchor),
            embeddedAddButtonView.bottomAnchor.constraint(equalTo: bottomAnchor),
            embeddedAddButtonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            embeddedAddButtonView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
}

