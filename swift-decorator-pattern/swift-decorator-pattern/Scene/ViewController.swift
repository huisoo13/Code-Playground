//
//  ViewController.swift
//  swift-decorator-pattern
//
//  Created by 정희수 on 4/16/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var maratang: Maratang?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func printMaratang() {
        guard let maratang else {
            return
        }
        
        label.text = "\(maratang.description()), Cost: \(maratang.cost())"
    }

    @IBAction func selectMild(_ sender: UIButton) {
        let maratang = MildMaratang()
        self.maratang = maratang
        
        printMaratang()
    }
    
    @IBAction func selectLessSpicy(_ sender: UIButton) {
        let maratang = LessSpicyMaratang()
        self.maratang = maratang
        
        printMaratang()
    }
    
    @IBAction func selectSpicy(_ sender: UIButton) {
        let maratang = SpicyMaratang()
        self.maratang = maratang
        
        printMaratang()
    }
    
    @IBAction func addMeat(_ sender: UIButton) {
        guard let maratang else {
            return
        }
        
        self.maratang = Meat(decorated: maratang)
        
        printMaratang()
    }
    
    @IBAction func addNoodle(_ sender: UIButton) {
        guard let maratang else {
            return
        }
        
        self.maratang = Noodles(decorated: maratang)
        
        printMaratang()
    }
    
    @IBAction func addVegetable(_ sender: UIButton) {
        guard let maratang else {
            return
        }
        
        self.maratang = Vegetable(decorated: maratang)
        
        printMaratang()
    }
    
    @IBAction func removeMeat(_ sender: UIButton) {
        guard let maratang = maratang as? Topping else {
            return
        }
        
        self.maratang = maratang.removing(Meat.self)
        
        printMaratang()
    }
    
    @IBAction func removeNoodle(_ sender: UIButton) {
        guard let maratang = maratang as? Topping else {
            return
        }
        
        self.maratang = maratang.removing(Noodles.self)
        
        printMaratang()
    }
    
    @IBAction func removeVegetable(_ sender: UIButton) {
        guard let maratang = maratang as? Topping else {
            return
        }
        
        self.maratang = maratang.removing(Vegetable.self)
        
        printMaratang()
    }
}

