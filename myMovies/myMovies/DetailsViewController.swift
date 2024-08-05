//
//  DetailsViewController.swift
//  myMovies
//
//

import UIKit

class DetailsViewController: UIViewController {

    var movieID: String?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var plot: UITextView!
    @IBOutlet weak var directorLabel: UITextView!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var worthWachingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up the background color to black
        self.view.backgroundColor = UIColor.black

        // Seting up the navigation bar for title representation
        self.title = "Movie Details"
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = false
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.yellow
            ]
            navigationBar.barTintColor = UIColor.black
            navigationBar.tintColor = UIColor.white
        }

        // Fetching the  movie details if movieID is available
        if let movieID = movieID {
            fetchMovieDetails(movieID: movieID)
        }
    }

    private func fetchMovieDetails(movieID: String) {
        // Defining the Api based on movie ID
        let apiUrl = "https://www.omdbapi.com/?apikey=9e96a71f&i=\(movieID)"
        
        
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            return
        }

        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
          
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

          
            guard let data = data else {
                print("No data received")
                return
            }

            do {
               
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        self.updateUI(with: jsonResponse)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }

       
        task.resume()
    }

    private func updateUI(with movieDetails: [String: Any]) {
        //Updating the UI
        titleLabel.text = movieDetails["Title"] as? String
        yearLabel.text = movieDetails["Year"] as? String
        plot.text = movieDetails["Plot"] as? String

       
        let director = movieDetails["Director"] as? String ?? "Unknown"
        directorLabel.text = "\(director)"
        directorLabel.backgroundColor = UIColor.black
        directorLabel.textColor = UIColor.white

        
        let actorsList = movieDetails["Actors"] as? String ?? "Unknown"
        actors.text = "Actors: \(actorsList)"
        actors.backgroundColor = UIColor.black
        actors.textColor = UIColor.white

        
        let genre = movieDetails["Genre"] as? String ?? "Unknown"
        genreLabel.text = "Genre: \(genre)"
        genreLabel.backgroundColor = UIColor.black
        genreLabel.textColor = UIColor.white

       
        let language = movieDetails["Language"] as? String ?? "Unknown"
        languageLabel.text = "Language: \(language)"
        languageLabel.backgroundColor = UIColor.black
        languageLabel.textColor = UIColor.white
        
        let votes = movieDetails["imdbVotes"] as? String ?? "Unknwon"
     

        
        let rating = movieDetails["imdbRating"] as? String ?? "N/A"
        ratingLabel.text = "\(rating)/10  ⭐  ( \(votes) )"
        ratingLabel.backgroundColor = UIColor.black
        ratingLabel.textColor = UIColor.white

        // Modifying the worthwatching label based on rating
        if let ratingValue = Double(rating) {
            switch ratingValue {
            case 0..<6.5:
                worthWachingLabel.text = "Waste Of Time"
                worthWachingLabel.textColor = UIColor.red
            case 6.5..<7.5:
                worthWachingLabel.text = "One Time Watch"
                worthWachingLabel.textColor = UIColor.yellow
            case 7.5...10:
                worthWachingLabel.text = "Must Watch"
                worthWachingLabel.textColor = UIColor.green
            default:
                worthWachingLabel.text = "Rating Not Available"
                worthWachingLabel.textColor = UIColor.white
            }
        } else {
            worthWachingLabel.text = "Rating Not Available"
            worthWachingLabel.textColor = UIColor.white
        }

        // Loading the poster image
        if let posterURL = movieDetails["Poster"] as? String, let url = URL(string: posterURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

