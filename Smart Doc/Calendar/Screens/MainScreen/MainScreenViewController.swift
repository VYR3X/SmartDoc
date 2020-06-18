//
//  MainScreenViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана MainScreen.
protocol MainScreenViewControllable: UIViewController {

	func bind(polyclinics: [String], polyclinicsId: [String])

}

protocol MainScreenPresentableListener {

	func didLoad(_ viewController: MainScreenViewControllable)

	func openListOfDoctors()

	func didTapSpecialitiesCell(resourceID: String)

	func didTapDoctorsPhoto()

	func getPolyclinicList(completion: @escaping (Result<PolyclinicsViewModel, Error>) -> Void)

	func didTapOnPoliclynic(id: String, name: String)

	func didLoadDoctorName()
}

/// Главный экран
final class MainScreenViewController: UIViewController, MainScreenViewControllable {

	// MARK: UI
	private struct Constants {
		static let heightOfFilmCollectionView : CGFloat = 190
	}

    private let listener: MainScreenPresentableListener

	private var doctorsPhotoCollectionViewDelegate: DoctorsPhotoCollectionViewDelegate?

	private var doctorSpecialitiesCollectionDelegate: DoctorSpecialitiesCollectionDelegate?

	private let refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
		//refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refreshControl.backgroundColor = .clear // если не будет фона то анимация будет залезать на таблицу
		refreshControl.tintColor = .white
		return refreshControl
	}()

	private let massiveContainerView : UIView = {
		let view = UIView(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()

	private let newsImageNames = ["tass", "moscowCity", "rbk", "putin", "corona"]
	private let newsTitles = ["В москве с 9 июня отменяется пропуска и режим самоизоляции",
							  "Москва лучший город России",
							  "Помочь врачам или переложить плитку",
							  "Путин на месте и уходить некуда не собирается",
							  "Врачи ШУЕ уже выехаил "]

	private let newSubTitles = ["ТАСС", "РИА НОВОСТИ", "РБК", "LENTA.RU", "RAMBLER"]

	private let polyclinicAddress = ["Одинцовский р-н, поселок санатория им. Герцена",
									 "Грохольский пер., 31",
									 "Одинцовский р-н, поселок санатория им. Герцена",
									 "Одинцовский р-н, поселок санатория им. Герцена"]

	private let ratings = ["4.2", "4.6", "4.2", "4.2"]

	/// Контейнер вью для шапки экрана (новости, интерин, москва)
	private let newsContainerView : UIView = {
		let view = UIView(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()

	/// Коллекшн вью с новостями
	private lazy var newsCollectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(NewsViewCell.self, forCellWithReuseIdentifier: "filmCollectionView")
		collectionView.backgroundColor = .clear
		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
	}()

	private let interinNameLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.973, alpha: 1)
		label.text = "Интерин"
		label.textAlignment = .left
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 30)
		label.backgroundColor = .clear
		return label
	}()

	private let locationLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.973, alpha: 1)
		label.text = "Москва"
		label.textAlignment = .left
		label.textColor = .white2
		label.font = UIFont.systemFont(ofSize: 16)
		label.backgroundColor = .clear
		return label
	}()

	//MARK: - Second view

	/// Название поликлиник
	var polyclinics: [String] = []
	/// ID поликлиник
	var polyclinicsId: [String] = []

	private let containerViewWithRoundedView : UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		//view.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.973, alpha: 1)
		view.backgroundColor = .clear
		return view
	}()

	private let roundedView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 28
		view.backgroundColor = .white
		return view
	}()

	private let allMoviesLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = .white
		label.text = "Все специальности: "
		label.font = label.font.withSize(15)
		label.font = UIFont.boldSystemFont(ofSize: 20.0)
		label.textAlignment = .left
		return label
	}()

	private lazy var movieGenresCollectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "genres")
		collectionView.backgroundColor = .white
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.delegate = doctorSpecialitiesCollectionDelegate
		collectionView.dataSource = doctorSpecialitiesCollectionDelegate
		return collectionView
	}()

	private lazy var doctorPhotoCardCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(DoctorsPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "pikachu")

		collectionView.delegate = doctorsPhotoCollectionViewDelegate
		collectionView.dataSource = doctorsPhotoCollectionViewDelegate
		collectionView.backgroundColor = .white
		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
	}()

	private let allMoviesButton : UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = UIColor(red: 0, green: 0, blue: 0.078, alpha: 0.04)
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(openDoctorsList(sender:)), for: .touchUpInside)
		var label = UILabel()
		label.frame = CGRect(x: 100, y: 12, width: 175, height: 20)
		label.textAlignment = .left
		label.text = "Открыть список врачей"
		label.font = label.font.withSize(15)
		button.addSubview(label)
		return button
	}()

	private let nearbyCinemasLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = .white
		label.text = "Поликлиники рядом"
		label.font = label.font.withSize(15)
		label.font = UIFont.boldSystemFont(ofSize: 20.0)
//		label.backgroundColor = .orange
		label.textAlignment = .left

		var imageView: UIImageView?
//		imageView?.backgroundColor = .ligthGreenColor
		var image: UIImage = UIImage(named:"compass")!
		imageView = UIImageView(image: image)
		imageView!.frame = CGRect(x: 351, y: 2, width: 24, height: 24)
		label.addSubview(imageView!)

		return label
	}()

	/// Полиниклиники рядом список
	lazy var cinemaTableView : UITableView = {
		let table = UITableView()
		table.delegate = self
		table.dataSource = self
		table.translatesAutoresizingMaskIntoConstraints = false
		table.register(NearbyPolyclinicsViewCell.self, forCellReuseIdentifier: "tableViewCell")
		table.backgroundColor = .white
		return table
	}()

	private let allMovieTheatersButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = UIColor(red: 0, green: 0, blue: 0.078, alpha: 0.04)
		button.layer.cornerRadius = 20
		var label = UILabel()
		label.sizeToFit()
		label.frame = CGRect(x: 126, y: 12, width: 150, height: 20)
		label.textAlignment = .left
		label.text = "Все поликлиники"
		label.font = label.font.withSize(15)
		button.addSubview(label)
		return button
	}()

    init(listener: MainScreenPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
		doctorSpecialitiesCollectionDelegate = DoctorSpecialitiesCollectionDelegate(listener: listener)
		doctorsPhotoCollectionViewDelegate = DoctorsPhotoCollectionViewDelegate(listener: listener)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		listener.didLoad(self)
		let scrollView = UIScrollView(frame: self.view.bounds)
		scrollView.showsVerticalScrollIndicator = false
		scrollView.refreshControl = refreshControl

		newsContainerView.addSubviews(newsCollectionView,
									  interinNameLabel,
									  locationLabel)

		roundedView.addSubviews(allMoviesLabel,
								movieGenresCollectionView,
								doctorPhotoCardCollectionView,
								allMoviesButton,
								allMovieTheatersButton,
								nearbyCinemasLabel,
								cinemaTableView)

		containerViewWithRoundedView.addSubview(roundedView)

		massiveContainerView.addSubviews(newsContainerView, containerViewWithRoundedView)

		view.addSubview(scrollView)
		scrollView.addSubview(massiveContainerView)
		scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 450 )

		setupConstraint()
		setupConstraintForSecondViewController()
		listener.didLoad(self)
		setGradient()
	}

	@objc private func openDoctorsList(sender: UIButton) {
		listener.openListOfDoctors()
	}

	func bind(polyclinics: [String], polyclinicsId: [String]) {
		self.polyclinics = polyclinics
		self.polyclinicsId = polyclinicsId
		self.cinemaTableView.reloadData()
	}

	@objc private func refresh(sender: UIRefreshControl) {
		// TO:DO самая жопа тут вообще нужно послать как минумум 4 запроса
		// все распарсить и отобразить заново
		// хз одним разом или последовательно
		listener.getPolyclinicList { (result) in
					switch result {
					case .success(let result):
						print(result)
						self.polyclinics = result.organizations
						self.polyclinicsId = result.organizatiosId
					case .failure(_):
						print("Я хз чи шо, You Know ??? ")
					}
		//			state = 1
				}
		self.cinemaTableView.reloadData()
		sender.endRefreshing()
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
	}

	private func setupConstraint() {

			NSLayoutConstraint.activate([

				massiveContainerView.heightAnchor.constraint(equalToConstant: view.frame.height * 2),
				massiveContainerView.widthAnchor.constraint(equalToConstant: view.frame.width),
				massiveContainerView.topAnchor.constraint(equalTo: massiveContainerView.topAnchor , constant: 0),

				newsCollectionView.topAnchor.constraint(equalTo: newsContainerView.topAnchor, constant: 108),
				newsCollectionView.heightAnchor.constraint(equalToConstant: Constants.heightOfFilmCollectionView),
				newsCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),

				newsContainerView.heightAnchor.constraint(equalToConstant: 336),
				newsContainerView.widthAnchor.constraint(equalToConstant: view.frame.width),
				newsContainerView.topAnchor.constraint(equalTo: massiveContainerView.topAnchor, constant: 0),

				interinNameLabel.widthAnchor.constraint(equalToConstant: 28),
				interinNameLabel.topAnchor.constraint(equalTo: newsContainerView.topAnchor, constant: 32),
				interinNameLabel.rightAnchor.constraint(equalTo: newsContainerView.rightAnchor, constant: -16),
				interinNameLabel.leftAnchor.constraint(equalTo: newsContainerView.leftAnchor, constant: 20),

				locationLabel.heightAnchor.constraint(equalToConstant: 20),
				locationLabel.topAnchor.constraint(equalTo: newsContainerView.topAnchor, constant: 64),
				locationLabel.rightAnchor.constraint(equalTo: newsContainerView.rightAnchor, constant: -67),
				locationLabel.leftAnchor.constraint(equalTo: newsContainerView.leftAnchor, constant: 20)
				])
		}

		private func setupConstraintForSecondViewController() {

			NSLayoutConstraint.activate([

				containerViewWithRoundedView.topAnchor.constraint(equalTo: newsContainerView.bottomAnchor , constant: 0),
				containerViewWithRoundedView.heightAnchor.constraint(equalToConstant: view.frame.height),
				containerViewWithRoundedView.widthAnchor.constraint(equalToConstant: self.view.frame.width),

				roundedView.topAnchor.constraint(equalTo: containerViewWithRoundedView.topAnchor, constant: 0),
				roundedView.heightAnchor.constraint(equalToConstant: view.frame.height + 250),
				roundedView.leftAnchor.constraint(equalTo: view.leftAnchor),
				roundedView.rightAnchor.constraint(equalTo: view.rightAnchor),

				allMoviesLabel.bottomAnchor.constraint(equalTo: movieGenresCollectionView.topAnchor, constant: -4),
				allMoviesLabel.heightAnchor.constraint(equalToConstant: 28),
				allMoviesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
				allMoviesLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),

				movieGenresCollectionView.bottomAnchor.constraint(equalTo: doctorPhotoCardCollectionView.topAnchor, constant: 0),
				movieGenresCollectionView.heightAnchor.constraint(equalToConstant: 68),
				movieGenresCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),

				doctorPhotoCardCollectionView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 132),
				doctorPhotoCardCollectionView.heightAnchor.constraint(equalToConstant: 384),
				doctorPhotoCardCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),

				allMoviesButton.topAnchor.constraint(equalTo: doctorPhotoCardCollectionView.bottomAnchor, constant: 8),
				allMoviesButton.heightAnchor.constraint(equalToConstant: 44),
				allMoviesButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
				allMoviesButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

				nearbyCinemasLabel.bottomAnchor.constraint(equalTo: cinemaTableView.topAnchor, constant: -10),
				nearbyCinemasLabel.heightAnchor.constraint(equalToConstant: 22),
				nearbyCinemasLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
				nearbyCinemasLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

				cinemaTableView.topAnchor.constraint(equalTo: doctorPhotoCardCollectionView.bottomAnchor, constant: 112),
				cinemaTableView.heightAnchor.constraint(equalToConstant: 288),
				cinemaTableView.widthAnchor.constraint(equalToConstant: view.frame.width),

				allMovieTheatersButton.topAnchor.constraint(equalTo: cinemaTableView.bottomAnchor, constant: 8),
				allMovieTheatersButton.heightAnchor.constraint(equalToConstant: 44),
				allMovieTheatersButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
				allMovieTheatersButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
				])
		}
	}

// MARK: - UICollectionViewDataSource

extension MainScreenViewController: UICollectionViewDataSource {

	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return newSubTitles.count
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "filmCollectionView",for: indexPath) as? NewsViewCell else { return UICollectionViewCell() }

		cell.trailerImageView.image = UIImage(named: newsImageNames[indexPath.row])
		cell.titleLabel.text = newsTitles[indexPath.row]
		cell.subtitleLabel.text = newSubTitles[indexPath.row]
		//cell.layer.cornerRadius = 10
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 248, height: 190)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 16)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 16
	}
}

// MARK: - UITableViewDataSource

extension MainScreenViewController : UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return polyclinics.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = cinemaTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! NearbyPolyclinicsViewCell

		cell.polyclinicNameLabel.text = polyclinics[indexPath.row]
		cell.polyclinicAddressLabel.text = polyclinicAddress[indexPath.row]
		cell.polyclinicRatingLabel.text = ratings[indexPath.row]
		return cell
	}
}

// MARK: - UITableViewDelegate

extension MainScreenViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 96
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let selectPolyclinic = polyclinics[indexPath.row];
		let polyclinicsID = polyclinicsId[indexPath.row];
		print("Выбранная поликлиника: \(selectPolyclinic) с присвоенным ID: \(polyclinicsID)")
		listener.didTapOnPoliclynic(id: polyclinicsID, name: selectPolyclinic)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
