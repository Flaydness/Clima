//
//  ViewController.swift
//  Clima
//
//  Created by Никита Ясеник on 26.01.2023.
//

import UIKit
import SwiftUI

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.countLabel.text = weather.temperatureString
            self.moonImageView.image = UIImage(systemName: weather.conditionName)
            self.townLabel.text = weather.cityName
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    var weatherManager = WeatherManager()
    
    lazy private var backroundImageView: UIImageView = {
        var image = UIImage(named: "background")!
        var imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var townTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .gray.withAlphaComponent(0.2)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.placeholder = "Search"
        textField.keyboardType = .alphabet
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 10, 0))
        
        textField.rightView = paddingView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    lazy private var searchImage: UIImage = {
        let image = UIImage(systemName: "magnifyingglass")!
        
        return image
        
    }()
    
    lazy private var celsiusLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(80)
        
        return label
    }()
    
    lazy private var countLabel: UILabel = {
        let label = UILabel()
        label.text = "21"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(80)
        
        return label
    }()
    
    lazy private var townLabel: UILabel = {
        let label = UILabel()
        label.text = "London"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = label.font.withSize(30)
        
        return label
    }()
    
    lazy private var houseImage: UIImage = {
        let image = UIImage(systemName: "house")!
        
        return image
        
    }()

    
    lazy private var moonImageView: UIImageView = {
        let moonImageView = UIImageView(image: UIImage(systemName: "moon"))
        moonImageView.translatesAutoresizingMaskIntoConstraints = false
        moonImageView.tintColor = .black
        
        return moonImageView
    }()
    
    lazy private var searchButton: UIButton = {
        
        var buttonBack = UIBackgroundConfiguration.listPlainCell()
        buttonBack.image = searchImage
        buttonBack.imageContentMode = .scaleAspectFit
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.background = buttonBack
        
        
        let button = UIButton(configuration: buttonConfig, primaryAction: UIAction(){ _ in
            self.townTextField.endEditing(true)
        })
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text {
            weatherManager.fetchWeather(cityName: cityName)
        }
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Print something ..."
            return false
        }
    }
    
    lazy private var houseButton: UIButton = {
        
        var buttonBack = UIBackgroundConfiguration.listPlainCell()
        buttonBack.image = houseImage
        buttonBack.imageContentMode = .scaleAspectFit
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.background = buttonBack
        
        
        let button = UIButton(configuration: buttonConfig)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    func setupView() {
        view.addSubview(backroundImageView)
        view.addSubview(townTextField)
        view.addSubview(searchButton)
        view.addSubview(houseButton)
        view.addSubview(moonImageView)
        view.addSubview(celsiusLabel)
        view.addSubview(countLabel)
        view.addSubview(townLabel)
        
        NSLayoutConstraint.activate([
            townTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            townTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            townTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            townTextField.heightAnchor.constraint(equalToConstant: 40),
            backroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.leftAnchor.constraint(equalTo: townTextField.rightAnchor, constant: 15),
            searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalTo: townTextField.heightAnchor),
            houseButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            houseButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            houseButton.heightAnchor.constraint(equalTo: townTextField.heightAnchor),
            houseButton.rightAnchor.constraint(equalTo: townTextField.leftAnchor, constant:  -15),
            moonImageView.rightAnchor.constraint(equalTo: searchButton.rightAnchor),
            moonImageView.topAnchor.constraint(equalTo: townTextField.bottomAnchor, constant: 5),
            moonImageView.heightAnchor.constraint(equalToConstant: 100),
            moonImageView.widthAnchor.constraint(equalToConstant: 100),
            celsiusLabel.topAnchor.constraint(equalTo: moonImageView.bottomAnchor, constant: 10),
            celsiusLabel.rightAnchor.constraint(equalTo: moonImageView.rightAnchor),
            celsiusLabel.heightAnchor.constraint(equalToConstant: 100),
            celsiusLabel.widthAnchor.constraint(equalToConstant: 100),
            countLabel.rightAnchor.constraint(equalTo: celsiusLabel.leftAnchor, constant: -10),
            countLabel.topAnchor.constraint(equalTo: moonImageView.bottomAnchor, constant: 10),
            countLabel.widthAnchor.constraint(equalToConstant: 200),
            countLabel.heightAnchor.constraint(equalToConstant: 100),
            townLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 5),
            townLabel.rightAnchor.constraint(equalTo: celsiusLabel.rightAnchor),
            townLabel.heightAnchor.constraint(equalToConstant: 50),
            townLabel.leftAnchor.constraint(equalTo: countLabel.leftAnchor)
            
            
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        townTextField.delegate = self
        weatherManager.delegate = self
        
        setupView()
        
    }


}

struct MyProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return WeatherViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
