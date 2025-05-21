//
//  ThreeViewController.swift
//  Swift-Playground
//
//  Created by 정희수 on 5/21/25.
//

import UIKit

class ThreeViewController: UIViewController {
    var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ThreeViewController: RootViewDelegate {
    func rootViewController(_ viewController: UIViewController) {
        viewController.setTitle("3")
    }
}
