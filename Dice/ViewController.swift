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
        self.view = HomeView(frame: UIScreen.main.bounds)
    }
}

class HomeView: UIView {
    
    // MARK: - UI Elements
    
    private let background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GreenBackground.png")
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dice1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dice2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let rollButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Roll", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.backgroundColor = UIColor(red: 0.6, green: 0.1, blue: 0.1, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var diceArray: [UIImage] {
        return [
            UIImage(named: "DiceOne")!,
            UIImage(named: "DiceTwo")!,
            UIImage(named: "DiceThree")!,
            UIImage(named: "DiceFour")!,
            UIImage(named: "DiceFive")!,
            UIImage(named: "DiceSix")!
        ]
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupScreen() {
        setupBackground()
        setupDiceStackView()
        setupRollButton()
    }
    
    private func setupBackground() {
        addSubview(background)
        NSLayoutConstraint.activate([
            background.leftAnchor.constraint(equalTo: self.leftAnchor),
            background.rightAnchor.constraint(equalTo: self.rightAnchor),
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupDiceStackView() {
        background.addSubview(stView)
        stView.addArrangedSubview(dice1)
        stView.addArrangedSubview(dice2)
        
        updateDiceImages()
        
        NSLayoutConstraint.activate([
            stView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            stView.widthAnchor.constraint(equalToConstant: 230),
            stView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupRollButton() {
        background.addSubview(rollButton)
        rollButton.addTarget(self, action: #selector(onClickRoll), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rollButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            rollButton.topAnchor.constraint(equalTo: stView.bottomAnchor, constant: 30),
            rollButton.widthAnchor.constraint(equalToConstant: 100),
            rollButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    @objc private func onClickRoll() {
        animateRollButton(rollButton)
        animateDiceRoll()
        updateDiceImages()
    }
    
    // MARK: - Helper
    
    private func updateDiceImages() {
        dice1.image = diceArray.randomElement()
        dice2.image = diceArray.randomElement()
    }
    
    private func animateRollButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                button.transform = CGAffineTransform.identity
            })
        }
    }
    
    private func animateDiceRoll() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dice1.transform = CGAffineTransform(rotationAngle: .pi)
            self.dice2.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            self.dice1.transform = .identity
            self.dice2.transform = .identity
        }
    }
}
