//
//  MainScreenViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана MainScreen.
protocol MainScreenViewControllable: UIViewController {}

protocol MainScreenPresentableListener {

	func didLoad(_ viewController: MainScreenViewControllable)

	func openListOfDoctors()

	func didTapSpecialitiesCell(resourceID: String)

	func didTapDoctorsPhoto()
}

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

	private let cinemaLabel : UILabel = {
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
		label.textAlignment = .left

		var imageView: UIImageView?
//		imageView?.backgroundColor = .ligthGreenColor
		var image: UIImage = UIImage(named:"heart")!
		imageView = UIImageView(image: image)
		imageView!.frame = CGRect(x: 351, y: 2, width: 24, height: 24)
		label.addSubview(imageView!)

		return label
	}()

	private lazy var cinemaTableView : UITableView = {
		let table = UITableView()
		table.delegate = self
		table.dataSource = self
		table.translatesAutoresizingMaskIntoConstraints = false
		table.register(NearbyPolyclinicsViewCell.self, forCellReuseIdentifier: "tableViewCell")
		table.backgroundColor = .white
		return table
	}()

	private let allMovieTheatersButton : UIButton = {
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

		let scrollView = UIScrollView(frame: self.view.bounds)
		scrollView.showsVerticalScrollIndicator = false
		scrollView.refreshControl = refreshControl

		newsContainerView.addSubviews(newsCollectionView,
									  cinemaLabel,
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
		scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 350 )

		setupConstraint()
		setupConstraintForSecondViewController()
		listener.didLoad(self)
		setGradient()
	}

	@objc private func openDoctorsList(sender: UIButton) {
		listener.openListOfDoctors()
	}

	@objc private func refresh(sender: UIRefreshControl) {
		// TO:DO самая жопа тут вообще нужно послать как минумум 4 запроса
		// все распарсить и отобразить заново
		// хз одним разом или последовательно
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
				newsContainerView.topAnchor.constraint(equalTo: massiveContainerView.topAnchor, constant: 0), // от вершины шторки

				cinemaLabel.heightAnchor.constraint(equalToConstant: 343),
				cinemaLabel.widthAnchor.constraint(equalToConstant: 28),
				cinemaLabel.topAnchor.constraint(equalTo: newsContainerView.topAnchor, constant: 32),
				cinemaLabel.rightAnchor.constraint(equalTo: newsContainerView.rightAnchor, constant: -16),
				cinemaLabel.bottomAnchor.constraint(equalTo: newsContainerView.bottomAnchor, constant: -276),
				cinemaLabel.leftAnchor.constraint(equalTo: newsContainerView.leftAnchor, constant: 16),

				locationLabel.heightAnchor.constraint(equalToConstant: 20),
				locationLabel.widthAnchor.constraint(equalToConstant: 292),
				locationLabel.topAnchor.constraint(equalTo: newsContainerView.topAnchor, constant: 64),
				locationLabel.rightAnchor.constraint(equalTo: newsContainerView.rightAnchor, constant: -67),
				locationLabel.bottomAnchor.constraint(equalTo: newsContainerView.bottomAnchor, constant: -252),
				locationLabel.leftAnchor.constraint(equalTo: newsContainerView.leftAnchor, constant: 16)
				])
		}

		private func setupConstraintForSecondViewController() {

			NSLayoutConstraint.activate([

				containerViewWithRoundedView.topAnchor.constraint(equalTo: newsContainerView.bottomAnchor , constant: 0),
				containerViewWithRoundedView.heightAnchor.constraint(equalToConstant: view.frame.height),
				containerViewWithRoundedView.widthAnchor.constraint(equalToConstant: self.view.frame.width),

				roundedView.topAnchor.constraint(equalTo: containerViewWithRoundedView.topAnchor, constant: 0),
				roundedView.heightAnchor.constraint(equalToConstant: view.frame.height),
				roundedView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
				roundedView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
				roundedView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),

				allMoviesLabel.bottomAnchor.constraint(equalTo: movieGenresCollectionView.topAnchor, constant: -4),
				allMoviesLabel.heightAnchor.constraint(equalToConstant: 28),
				allMoviesLabel.widthAnchor.constraint(equalToConstant: 343),
				allMoviesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
				allMoviesLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

				movieGenresCollectionView.bottomAnchor.constraint(equalTo: doctorPhotoCardCollectionView.topAnchor, constant: 0),
				movieGenresCollectionView.heightAnchor.constraint(equalToConstant: 68),
				movieGenresCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),

				doctorPhotoCardCollectionView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 132),
				doctorPhotoCardCollectionView.heightAnchor.constraint(equalToConstant: 384),
				doctorPhotoCardCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),

				allMoviesButton.topAnchor.constraint(equalTo: doctorPhotoCardCollectionView.bottomAnchor, constant: 8),
				allMoviesButton.heightAnchor.constraint(equalToConstant: 44),
				allMoviesButton.widthAnchor.constraint(equalToConstant: 343),
				allMoviesButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
				allMoviesButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

				nearbyCinemasLabel.bottomAnchor.constraint(equalTo: cinemaTableView.topAnchor, constant: 0),
				nearbyCinemasLabel.heightAnchor.constraint(equalToConstant: 22),
				nearbyCinemasLabel.widthAnchor.constraint(equalToConstant: 343),
				nearbyCinemasLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
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

extension MainScreenViewController : UICollectionViewDataSource {

	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "filmCollectionView",for: indexPath) as? NewsViewCell else { return UICollectionViewCell() }
		// TO:DO добавить новости
		return cell
	}
}

extension MainScreenViewController : UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 248, height: 190 )
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 16
	}
}

extension MainScreenViewController : UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell: UITableViewCell = cinemaTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! NearbyPolyclinicsViewCell
		return cell
	}
}

extension MainScreenViewController : UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 96
	}
}
