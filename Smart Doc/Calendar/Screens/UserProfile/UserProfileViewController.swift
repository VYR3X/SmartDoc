//
//  UserProfileViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана UserProfile.
protocol UserProfileViewControllable: UIViewController {}

protocol UserProfilePresentableListener {

	func didLoad(_ viewController: UserProfileViewControllable)

	func openDoctorsSpecialities()
}

final class UserProfileViewController: UIViewController, UserProfileViewControllable, UIScrollViewDelegate {

    private let listener: UserProfilePresentableListener

	// MARK: Scroll View

	private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 75)

	/// Скролл вью
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView(frame: view.bounds)
		//scrollView.backgroundColor = .orange
		scrollView.contentSize = contentViewSize
		scrollView.showsVerticalScrollIndicator = false
		//scrollView.alwaysBounceVertical = true //???
		return scrollView
	}()

	///  Вью содержащее весь контент
	private lazy var contentView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		view.frame.size = contentViewSize
		return view
	}()

	// MARK: UI

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
		//view.backgroundColor = UIColor(red: 182/255, green: 250/255, blue: 244/255, alpha: 1)
		//view.backgroundColor = .white
		view.backgroundColor = Colors.mainColor
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
		textField.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)
		//textField.backgroundColor = .orange
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.delegate = self
		textField.sizeToFit()
//		textField.placeholder = "Введите ФИО"
		let color = UIColor.white
		textField.attributedPlaceholder = NSAttributedString(string: "Введите ФИО", attributes: [NSAttributedString.Key.foregroundColor : color])
		//textField.text = "ФИО"
		textField.autocapitalizationType = .words // каждое слово с большой буквы
		return textField
	}()

	/// дата рождения
	lazy var birthdayTextField: UITextField = {
		let textField = UITextField()
		textField.sizeToFit()
		textField.translatesAutoresizingMaskIntoConstraints = false
		let color = UIColor.white
		textField.attributedPlaceholder = NSAttributedString(string: "Введите дату рождения", attributes: [NSAttributedString.Key.foregroundColor : color])
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)
		textField.delegate = self
		return textField
	}()


	/// telephone number
	lazy var telephoneTextField: UITextField = {
		let textField = UITextField()
		textField.sizeToFit()
		textField.translatesAutoresizingMaskIntoConstraints = false
		let color = UIColor.white
		textField.attributedPlaceholder = NSAttributedString(string: "Введите номер телефона", attributes: [NSAttributedString.Key.foregroundColor : color])
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.backgroundColor = Colors.mainColor
		textField.delegate = self
		textField.textColor = .white2
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
		textField.backgroundColor = Colors.mainColor
		textField.keyboardType = .emailAddress

		let color = UIColor.white
		textField.attributedPlaceholder = NSAttributedString(string: "Введите почту", attributes: [NSAttributedString.Key.foregroundColor : color])
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.delegate = self
		textField.textColor = .white2

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
		let color = UIColor.white
		textField.attributedPlaceholder = NSAttributedString(string: "Введите полис", attributes: [NSAttributedString.Key.foregroundColor : color])
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.textColor = .white2
		textField.delegate = self
		textField.backgroundColor = Colors.mainColor
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
		//view.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)

		configureNavigationBar()
		setupView()
		configureTapGestureToCloseKeyBoard()
		setGradient()

		if UserSettings.userModel != nil {
			showSavedDataInTextFields()
		}
	}

	private func setGradient() {
		let gradient: CAGradientLayer = CAGradientLayer()

		let leftColor = Colors.mainColor
		let rightColor = UIColor.purple

		gradient.colors = [leftColor.cgColor, rightColor.cgColor]
		gradient.locations = [0.0 , 1.0]
		gradient.startPoint = CGPoint(x: 0.4, y: 0.6)
		gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
		gradient.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)

		view.layer.insertSublayer(gradient, at: 0)
		//backgroungRoundView.layer.insertSublayer(gradient, at: 0)
	}

	@objc func saveButtonAction(sender: UIBarButtonItem) {

		// TO:DO - приходит фио а нужны только  имя и фамилия значит нужно спарсить строку
		let nameTrimmingText = fioTextField.text!.trimmingCharacters(in: .whitespaces)
        let birthdateTrimmingText = birthdayTextField.text!.trimmingCharacters(in: .whitespaces)
		let telephoneTrimmingText = telephoneTextField.text!.trimmingCharacters(in: .whitespaces)
        let emailTrimmingText = emailTextField.text!.trimmingCharacters(in: .whitespaces)
		let polisTrimmingText = polisTextField.text!.trimmingCharacters(in: .whitespaces)

        let userObject = UserProfileModel(name: nameTrimmingText,
										  birthdate: birthdateTrimmingText,
										  telephone: telephoneTrimmingText,
										  email: emailTrimmingText,
										  polis: polisTrimmingText)

		UserSettings.userModel = userObject // сохраняю в память устройства введенные данные

		listener.openDoctorsSpecialities()
	}

	private func configureNavigationBar() {
		self.title = "Профиль"
		self.navigationController?.navigationBar.isTranslucent = false
		self.navigationController?.navigationBar.backgroundColor = .orange

		let rightBarBtn = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonAction))
		self.navigationItem.rightBarButtonItem = rightBarBtn
		/// пока заглушка чтобы не могли перейти назад
		self.navigationItem.leftBarButtonItem = UIBarButtonItem()
	}

	private func showSavedDataInTextFields() {
		fioTextField.text = UserSettings.userModel.name
		birthdayTextField.text = UserSettings.userModel.birthdate
		telephoneTextField.text = UserSettings.userModel.telephone
		emailTextField.text = UserSettings.userModel.email
		polisTextField.text = UserSettings.userModel.polis
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

		view.addSubview(scrollView)
		scrollView.addSubview(contentView)

		contentView.addSubviews(profileImageView,
						 backgroungProfileView)

		backgroungProfileView.addSubviews(backgroungRoundView,
										  telephoneTextField,
										  telephoneImageView,
										  emailTextField,
										  emailImageView,
										  polisTextField,
										  polisImageView)

		backgroungRoundView.addSubviews(fioTextField,
										birthdayTextField)

		setupConstraints()
	}

	private func setupConstraints() {

			let screenSize: CGRect = UIScreen.main.bounds

			let screenHeight = screenSize.height

			NSLayoutConstraint.activate([

				profileImageView.heightAnchor.constraint(equalToConstant: screenHeight / 5.5),
				profileImageView.widthAnchor.constraint(equalToConstant: screenHeight / 5.5),
				profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
				profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

				backgroungProfileView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 45),
				backgroungProfileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
				backgroungProfileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
				backgroungProfileView.heightAnchor.constraint(equalToConstant: 500),

				backgroungRoundView.heightAnchor.constraint(equalToConstant: screenHeight / 6),
				backgroungRoundView.topAnchor.constraint(equalTo: backgroungProfileView.topAnchor, constant: 45),
				backgroungRoundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
				backgroungRoundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

				fioTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				fioTextField.topAnchor.constraint(equalTo: backgroungRoundView.topAnchor, constant: 11),
				fioTextField.leadingAnchor.constraint(equalTo: backgroungRoundView.leadingAnchor, constant: 45),
				fioTextField.trailingAnchor.constraint(equalTo: backgroungRoundView.trailingAnchor, constant: -45),

				birthdayTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				birthdayTextField.topAnchor.constraint(equalTo: fioTextField.bottomAnchor, constant: 10),
				birthdayTextField.leadingAnchor.constraint(equalTo: backgroungRoundView.leadingAnchor, constant: 45),
				birthdayTextField.trailingAnchor.constraint(equalTo: backgroungRoundView.trailingAnchor, constant: -45),
				backgroungRoundView.bottomAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 10),

				telephoneTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				telephoneTextField.topAnchor.constraint(equalTo: backgroungRoundView.bottomAnchor, constant: 35),
				telephoneTextField.leadingAnchor.constraint(equalTo: telephoneImageView.trailingAnchor, constant: 25),
				telephoneTextField.trailingAnchor.constraint(equalTo: backgroungRoundView.trailingAnchor, constant: -25),

				telephoneImageView.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				telephoneImageView.widthAnchor.constraint(equalToConstant: 100),
				telephoneImageView.topAnchor.constraint(equalTo: backgroungRoundView.bottomAnchor, constant: 35),
				telephoneImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),


				emailTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				emailTextField.topAnchor.constraint(equalTo: telephoneTextField.bottomAnchor, constant: 25),
				emailTextField.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor, constant: 25),
				emailTextField.trailingAnchor.constraint(equalTo: backgroungRoundView.trailingAnchor, constant: -25),

				emailImageView.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				emailImageView.widthAnchor.constraint(equalToConstant: 100),
				emailImageView.topAnchor.constraint(equalTo: telephoneTextField.bottomAnchor, constant: 25),
				emailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

				polisTextField.heightAnchor.constraint(equalToConstant: screenHeight / 17),
				polisTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
				polisTextField.leadingAnchor.constraint(equalTo: polisImageView.trailingAnchor, constant: 25),
				polisTextField.trailingAnchor.constraint(equalTo: backgroungRoundView.trailingAnchor, constant: -25),

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
