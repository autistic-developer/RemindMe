import UIKit
import SwiftUI

@IBDesignable
class AddButtonUIView: UIControl {
    
    
    private var hostingController: UIHostingController<AddButtonView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard hostingController == nil else { return }
        
        
        
        let addButtonView = AddButtonView(onTab: {[weak self] in
            self?.sendActions(for: .allTouchEvents)
        })
        hostingController = UIHostingController(rootView: addButtonView)
        
        guard let embeddedAddButtonView = hostingController?.view else { return }
        
        embeddedAddButtonView.backgroundColor = .clear
        embeddedAddButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(embeddedAddButtonView)
        
        NSLayoutConstraint.activate([
            embeddedAddButtonView.topAnchor.constraint(equalTo: topAnchor),
            embeddedAddButtonView.bottomAnchor.constraint(equalTo: bottomAnchor),
            embeddedAddButtonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            embeddedAddButtonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            embeddedAddButtonView.widthAnchor.constraint(equalToConstant: 78.w),
            embeddedAddButtonView.heightAnchor.constraint(equalToConstant: 78.w)
        ])
        
    }
}
