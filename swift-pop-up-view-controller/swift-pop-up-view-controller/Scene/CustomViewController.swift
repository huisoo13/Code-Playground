/*
    Created by Huisoo on 2025-06-20
*/

import UIKit

class CustomViewController: PopupViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        dismiss(animated: true)
    }

    private func setupView() {
        containerView.layer.cornerRadius = 8
    }
}
