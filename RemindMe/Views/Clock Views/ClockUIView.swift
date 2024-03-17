
import UIKit
import SwiftUI

@IBDesignable
class ClockUIView: UIView {
    private var hostingController: UIHostingController<ClockView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard hostingController == nil else { return }
        
        let clockView = ClockView()
        hostingController = UIHostingController(rootView: clockView)
        
        guard let embeddedClockView = hostingController?.view else { return }
        
        embeddedClockView.backgroundColor = .clear
        embeddedClockView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(embeddedClockView)
        
        NSLayoutConstraint.activate([
            embeddedClockView.topAnchor.constraint(equalTo: topAnchor),
            embeddedClockView.bottomAnchor.constraint(equalTo: bottomAnchor),
            embeddedClockView.leadingAnchor.constraint(equalTo: leadingAnchor),
            embeddedClockView.trailingAnchor.constraint(equalTo: trailingAnchor),
            embeddedClockView.widthAnchor.constraint(equalToConstant: 203.w),
            embeddedClockView.heightAnchor.constraint(equalToConstant: 203.w)
        ])
        
    }
}

