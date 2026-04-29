import Flutter
import UIKit
import AdPlayerLite

final class AdPlayerFlutterPlatformView: NSObject, FlutterPlatformView {
    private let containerView: PlayerWrapperView
    
    // MARK: - Init 'PlacementView' Flutter wrapper
    init(frame: CGRect, controller: AdPlayerInReadController) {
        self.containerView = PlayerWrapperView(frame: frame, controller: controller)
        super.init()
    }
    
    func view() -> UIView {
        return containerView
    }
}

final class PlayerWrapperView: UIView {
    private let controller: AdPlayerInReadController
    private var placement: AdPlacementView?
    
    init(frame: CGRect, controller: AdPlayerInReadController) {
        self.controller = controller
        super.init(frame: frame)
        
        let placement = AdPlacementView()
        placement.attachController(controller)
        self.placement = placement
        
        clipsToBounds = true
        addSubview(placement)
        placement.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placement.topAnchor.constraint(equalTo: topAnchor),
            placement.bottomAnchor.constraint(equalTo: bottomAnchor),
            placement.leadingAnchor.constraint(equalTo: leadingAnchor),
            placement.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
