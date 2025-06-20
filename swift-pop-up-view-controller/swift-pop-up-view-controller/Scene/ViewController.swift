/*
    Created by Huisoo on 2025-06-20
*/

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        stackView.arrangedSubviews.forEach { button in
            button.layer.cornerRadius = 8
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
        }
    }

    @IBAction func fadeAction(_ sender: Any) {
        let viewController = CustomViewController(nibName: "CustomViewController", bundle: nil)
        viewController.presentationStyle = .fade
        present(viewController, animated: false)
    }
    
    @IBAction func rightAction(_ sender: Any) {
        let viewController = CustomViewController(nibName: "CustomViewController", bundle: nil)
        viewController.presentationStyle = .translate(.right)
        viewController.blurEffectStyle = .light
        present(viewController, animated: false)
    }
    
    @IBAction func leftAction(_ sender: Any) {
        let viewController = CustomViewController(nibName: "CustomViewController", bundle: nil)
        viewController.presentationStyle = .translate(.left)
        present(viewController, animated: false)
    }
    
    @IBAction func topAction(_ sender: Any) {
        let viewController = CustomViewController(nibName: "CustomViewController", bundle: nil)
        viewController.presentationStyle = .translate(.top)
        present(viewController, animated: false)
    }
    
    @IBAction func bottomAction(_ sender: Any) {
        let viewController = CustomViewController(nibName: "CustomViewController", bundle: nil)
        viewController.presentationStyle = .translate(.bottom)
        present(viewController, animated: false)
    }
}

