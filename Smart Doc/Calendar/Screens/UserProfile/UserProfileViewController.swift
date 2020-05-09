//
//  UserProfileViewController.swift
//  Smart Doc
//
//  Created by 17790204 on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана UserProfile.
protocol UserProfileViewControllable: UIViewController {}

protocol UserProfilePresentableListener {

	func didLoad(_ viewController: UserProfileViewControllable)

	func openDoctorsSpecialities()
}

final class UserProfileViewController: UIViewController, UserProfileViewControllable {

    private let listener: UserProfilePresentableListener

	// MARK: UI

	/// Лэйбл "Персональные данные"
	let personalData: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Персональные данные"

		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowOpacity = 1
		label.layer.shadowOffset = .zero
		label.layer.shadowRadius = 7
		return label
	}()

	/// Картинка пациента
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false

		let screenSize: CGRect = UIScreen.main.bounds
		imageView.layer.cornerRadius = (screenSize.height / 7) / 2

		imageView.backgroundColor = UIColor(red: 182/255, green: 250/255, blue: 244/255, alpha: 1)

		imageView.layer.shadowColor = UIColor.black.cgColor
		imageView.layer.shadowOpacity = 1
		imageView.layer.shadowOffset = .zero
		imageView.layer.shadowRadius = 7
		return imageView
	}()

	/// синяя подложка
	let backgroungProfileView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 40
		view.backgroundColor = .white

		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 1
		view.layer.shadowOffset = .zero
		view.layer.shadowRadius = 7

		return view
	}()

	/// синяя подложка
	let backgroungRoundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 45
		view.backgroundColor = UIColor(red: 182/255, green: 250/255, blue: 244/255, alpha: 1)

		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 1
		view.layer.shadowOffset = .zero
		view.layer.shadowRadius = 7

		return view
	}()

	/// фио
	lazy var fioTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.backgroundColor = .orange
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.delegate = self
		textField.sizeToFit()
		textField.placeholder = "Введите ФИО"
		//textField.text = "ФИО"
		textField.autocapitalizationType = .words // каждое слово с большой буквы
		return textField
	}()

	/// дата рождения
	lazy var birthdayTextField: UITextField = {
		let textField = UITextField()
		textField.sizeToFit()
		textField.translatesAutoresizingMaskIntoConstraints = false
		//textField.text = "Дата рождения"
		textField.placeholder = "Введите дату рождения"
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.backgroundColor = .orange
		textField.delegate = self
		return textField
	}()


	/// telephone number
	lazy var telephoneTextField: UITextField = {
		let textField = UITextField()
		textField.sizeToFit()
		textField.translatesAutoresizingMaskIntoConstraints = false
		//textField.text = "Телефон"
		textField.placeholder = "Введите номер телефона"
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.backgroundColor = .orange
		textField.delegate = self
		return textField
	}()

	/// telephone number
	let telephoneImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	/// email
	lazy var emailTextField: UITextField = {
		let textField = UITextField()
		textField.sizeToFit()
		textField.translatesAutoresizingMaskIntoConstraints = false
		//textField.placeholder = "Введите почту"
		//textField.text = "Почта"
		textField.backgroundColor = .orange
		textField.keyboardType = .emailAddress

		let color = UIColor.lightText
		textField.attributedPlaceholder = NSAttributedString(string: "Введите почту", attributes: [NSAttributedString.Key.foregroundColor : color])
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.delegate = self

		return textField
	}()

	/// telephone number
	let emailImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	/// полис
	lazy var polisTextField: UITextField = {
		let textField = UITextField()
		textField.sizeToFit()
		textField.translatesAutoresizingMaskIntoConstraints = false
		//textField.text = "полис"
		textField.placeholder = "Введите полис"
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.delegate = self
		textField.backgroundColor = .orange
		return textField
	}()

	/// telephone number
	let polisImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

    init(listener: UserProfilePresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
		listener.didLoad(self)
		view.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)
		setupView()
		configureTapGestureToCloseKeyBoard()

		self.title = "User Profile"
		self.navigationController?.navigationBar.isTranslucent = false

		let rightBarBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonAction))
		self.navigationItem.rightBarButtonItem = rightBarBtn
		/// пока загдушка чтобы не могли перейти назад
		self.navigationItem.leftBarButtonItem = UIBarButtonItem()
	}

	@objc func saveButtonAction(sender: UIBarButtonItem) {

		let nameTrimmingText = fioTextField.text!.trimmingCharacters(in: .whitespaces)
		// TO:DO - приходит фио а нужны толь  имя и фамилия значит нужно спарсить строку
        let birthdateTrimmingText = birthdayTextField.text!.trimmingCharacters(in: .whitespaces)
		let telephoneTrimmingText = telephoneTextField.text!.trimmingCharacters(in: .whitespaces)
        let emailTrimmingText = emailTextField.text!.trimmingCharacters(in: .whitespaces)
		let polisTrimmingText = polisTextField.text!.trimmingCharacters(in: .whitespaces)

        print(nameTrimmingText)

        let userObject = UserProfileModel(name: nameTrimmingText,
										  birthdate: birthdateTrimmingText,
										  telephone: telephoneTrimmingText,
										  email: emailTrimmingText,
										  polis: polisTrimmingText)

		//UserSettings.userName = nameTrimmingText
		UserSettings.userModel = userObject

		//print(UserSettings.userName)
		print(UserSettings.userModel)

		listener.openDoctorsSpecialities()
	}

	// метод для скрытия клавиатуры при нажатии по экрану
	private func configureTapGestureToCloseKeyBoard() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
		view.addGestureRecognizer(tapGesture)
	}

	@objc func handleTap() {
		print("Hand tap was called")
		view.endEditing(true)
	}

	private func setupView() {

		view.addSubview(personalData)
		view.addSubview(profileImageView)
		view.addSubview(backgroungProfileView)
		backgroungProfileView.addSubview(backgroungRoundView)
		backgroungRoundView.addSubview(fioTextField)
		backgroungRoundView.addSubview(birthdayTextField)
		backgroungProfileView.addSubview(telephoneTextField)
		backgroungProfileView.addSubview(telephoneImageView)
		backgroungProfileView.addSubview(emailTextField)
		backgroungProfileView.addSubview(emailImageView)
		backgroungProfileView.addSubview(polisTextField)
		backgroungProfileView.addSubview(polisImageView)

		setupConstraints()
	}

	private func setupConstraints() {

			let screenSize: CGRect = UIScreen.main.bounds

			let screenHeight = screenSize.height

			NSLayoutConstraint.activate([

				personalData.heightAnchor.constraint(equalToConstant: 25),
				personalData.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
				personalData.centerXAnchor.constraint(equalTo: view.centerXAnchor),

				profileImageView.heightAnchor.constraint(equalToConstant: screenHeight / 7),
				profileImageView.widthAnchor.constraint(equalToConstant: screenHeight / 7),
				profileImageView.topAnchor.constraint(equalTo: personalData.bottomAnchor, constant: 35),
				profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

				backgroungProfileView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25),
				backgroungProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				backgroungProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				backgroungProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

				backgroungRoundView.heightAnchor.constraint(equalToConstant: screenHeight / 6),
				backgroungRoundView.topAnchor.constraint(equalTo: backgroungProfileView.topAnchor, constant: 45),
				backgroungRoundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
				backgroungRoundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

				fioTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				fioTextField.topAnchor.constraint(equalTo: backgroungRoundView.topAnchor, constant: 10),
				//fio.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				fioTextField.leadingAnchor.constraint(equalTo: backgroungRoundView.leadingAnchor, constant: 25),
				fioTextField.trailingAnchor.constraint(equalTo: backgroungRoundView.trailingAnchor, constant: -25),

				birthdayTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				birthdayTextField.topAnchor.constraint(equalTo: fioTextField.bottomAnchor, constant: 10),
				//birthday.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				birthdayTextField.leadingAnchor.constraint(equalTo: backgroungRoundView.leadingAnchor, constant: 25),
				birthdayTextField.trailingAnchor.constraint(equalTo: backgroungRoundView.trailingAnchor, constant: -25),

				telephoneTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				telephoneTextField.topAnchor.constraint(equalTo: backgroungRoundView.bottomAnchor, constant: 45),
//				telephone.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				telephoneTextField.leadingAnchor.constraint(equalTo: telephoneImageView.trailingAnchor, constant: 25),
				telephoneTextField.trailingAnchor.constraint(equalTo: backgroungRoundView.trailingAnchor, constant: -25),

				telephoneImageView.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				telephoneImageView.widthAnchor.constraint(equalToConstant: 100),
				telephoneImageView.topAnchor.constraint(equalTo: backgroungRoundView.bottomAnchor, constant: 45),
				telephoneImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),


				emailTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				emailTextField.topAnchor.constraint(equalTo: telephoneTextField.bottomAnchor, constant: 25),
				emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

				emailImageView.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				emailImageView.widthAnchor.constraint(equalToConstant: 100),
				emailImageView.topAnchor.constraint(equalTo: telephoneTextField.bottomAnchor, constant: 25),
				emailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

				polisTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				polisTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
				polisTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

				polisImageView.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				polisImageView.widthAnchor.constraint(equalToConstant: 100),
				polisImageView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
				polisImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
			])
	}
}

extension UserProfileViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		// при нажатии на клавиатуре enter скрывается клавиатура
		textField.resignFirstResponder()
		return true
	}
}
