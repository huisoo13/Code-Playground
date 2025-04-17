//
//  ViewController.swift
//  swift-decorator-pattern
//
//  Created by 정희수 on 4/16/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        foo()
    }

    func foo() {
        let maratang1 = LessSpicyMaratang()
        let maratang2 = Meat(decorated: maratang1)
        let maratang3 = Noodles(decorated: maratang2)
        let maratang4 = Vegetable(decorated: maratang3)
        let maratang5 = Meat(decorated: maratang4)
        let maratang6 = maratang5.removing(Meat.self)
        let maratang7 = Vegetable(decorated: maratang6)
        
        print(maratang1.cost(), maratang1.description())
        print(maratang2.cost(), maratang2.description())
        print(maratang3.cost(), maratang3.description())
        print(maratang4.cost(), maratang4.description())
        print(maratang5.cost(), maratang5.description())
        print(maratang6.cost(), maratang6.description())
        print(maratang7.cost(), maratang7.description())
    }
}

