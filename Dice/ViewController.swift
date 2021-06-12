//
//  ViewController.swift
//  Dice
//
//  Created by Mohammad on 12/06/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view = MyHomeView(frame: UIScreen.main.bounds)
    }

}

class MyHomeView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupScreen()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScreen(){
        
        self.addSubview(background)
        background.addSubview(stView)
        stView.addArrangedSubview(dice1)
        stView.addArrangedSubview(dice2)
        background.addSubview(stView)
        background.addSubview(rollButton)
    }
    
    func setupConstraints(){
        
        setBackgroundConstraints()
        setDice()
        setRollButton()
    }
    
    func setBackgroundConstraints(){
        
        background.image = UIImage(named: "GreenBackground.png")
        background.isUserInteractionEnabled = true
        background.translatesAutoresizingMaskIntoConstraints = false
        background.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func setDice(){
        
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.leftAnchor.constraint(equalTo: centerXAnchor, constant: -115).isActive = true
        stView.topAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        stView.rightAnchor.constraint(equalTo: centerXAnchor, constant: 115).isActive = true
        stView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        
        stView.distribution = .fillEqually
        stView.alignment = .center
        stView.spacing = 30
        
        dice1.image = diceArray.randomElement()
        dice2.image = diceArray.randomElement()
    }
    
    func setRollButton(){
        
        rollButton.addTarget(self, action: #selector(self.onClickRoll), for: .touchUpInside)
        rollButton.setTitle("Roll", for: .normal)
        rollButton.layer.cornerRadius = 10
        rollButton.titleLabel?.font = .systemFont(ofSize: 25)
        rollButton.backgroundColor = #colorLiteral(red: 0.6075378656, green: 0.1114451364, blue: 0.1189513579, alpha: 1)
        rollButton.isUserInteractionEnabled = true
        
        rollButton.translatesAutoresizingMaskIntoConstraints = false
        rollButton.leftAnchor.constraint(equalTo: centerXAnchor, constant: -50).isActive = true
        rollButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
        rollButton.rightAnchor.constraint(equalTo: centerXAnchor, constant: 50).isActive = true
        rollButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 100).isActive = true
    }
    
    @objc func onClickRoll(){
        animateRollButton(rollButton)
        dice1.image = diceArray.randomElement()
        dice2.image = diceArray.randomElement()
    }
    
    func animateRollButton(_ viewToAnimate:UIButton){
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    let background = UIImageView()
    let dice1 = UIImageView()
    let dice2 = UIImageView()
    let stView = UIStackView()
    let rollButton = UIButton()
    let diceArray = [#imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix")]
}
