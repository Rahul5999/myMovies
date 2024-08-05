//
//  TableViewCell.swift
//  myMovies
//
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!

    var movieID: String?
    
    var isFavourite: Bool = false {
        didSet {
            updateFavouriteButton()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        favouriteBtn.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        self.contentView.backgroundColor = UIColor.black
        self.title.textColor = UIColor.white
        self.releaseDate.textColor = UIColor.white
    }

    @objc func favouriteButtonTapped() {
        guard let movieID = movieID else { return }
        isFavourite.toggle()
        saveFavouriteStatus(movieID: movieID, isFavourite: isFavourite)
    }
    
    //Updating Favouritemovie button based on the conditions whether it is liked or not
    private func updateFavouriteButton() {
        if isFavourite {
            favouriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favouriteBtn.tintColor = .red
        } else {
            favouriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            favouriteBtn.tintColor = .lightGray
        }
    }
    //Storing the details of the FavouritemovieStatus 
    private func saveFavouriteStatus(movieID: String, isFavourite: Bool) {
        var favourites = UserDefaults.standard.dictionary(forKey: "favourites") as? [String: Bool] ?? [:]
        favourites[movieID] = isFavourite
        UserDefaults.standard.set(favourites, forKey: "favourites")
    }

    func configure(movie: [String: Any], isFavourite: Bool) {
        self.movieID = movie["imdbID"] as? String
        self.isFavourite = isFavourite
        title.text = movie["Title"] as? String
        releaseDate.text = movie["Year"] as? String

        if let posterUrlString = movie["Poster"] as? String, let posterUrl = URL(string: posterUrlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: posterUrl) {
                    DispatchQueue.main.async {
                        self.posterImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

