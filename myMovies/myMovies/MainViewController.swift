//
//  MainViewController.swift
//  myMovies
//
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var movies: [[String: Any]] = []
    var filteredMovies: [[String: Any]] = []
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting the table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")

        // Setting the search bar
        searchBar.delegate = self
        customizeSearchBar()

        // Fetching movie details when view is loaded
        fetchMovieData()
    }

    //Setting the navigation bar programmatically for the title represenration
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.title = "myMovies"
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.yellow
            ]
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            navigationBar.barTintColor = UIColor.darkGray
            navigationBar.tintColor = UIColor.white
        }
    }

    //Fetching Movie Details
    private func fetchMovieData() {
        
        
        let apiUrl = "https://www.omdbapi.com/?apikey=9e96a71f&type=movie&s=Don"

        
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            return
        }

        // Creating a URL Session for getting data from api
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handling the errors errors
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            
            guard let data = data else {
                print("Data Not Found")
                return
            }

            do {
                // Parsing  the JSON response
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let searchResults = jsonResponse["Search"] as? [[String: Any]] {
                        self.movies = searchResults
                        self.filteredMovies = searchResults
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }

        // Starting the data rask
        task.resume()
    }
    
    //Modifying the Searchbar and making modifications of SearchBar UI
    private func customizeSearchBar() {
        
        searchBar.backgroundImage = UIImage()

        // Modifying the SearchBar TextField
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
            textField.layer.cornerRadius = 10
            textField.layer.masksToBounds = true
            textField.textColor = .black
            
            // Seting the placeholder text color
            if let placeholderLabel = textField.value(forKey: "placeholderLabel") as? UILabel {
                placeholderLabel.textColor = UIColor.lightGray
            }
            
            // Setting up  the left icon
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.lightGray
            }
        }

        // Removing Border around SearchBar
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true

        //Setting Background colour for SearchBar
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    //For eachcell at row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        let movie = filteredMovies[indexPath.row]
        let movieID = movie["imdbID"] as? String ?? ""
        let isFavourite = UserDefaults.standard.dictionary(forKey: "favourites")?[movieID] as? Bool ?? false

        cell.configure(movie: movie, isFavourite: isFavourite)

        return cell
    }
    //Performing Segue operation when selected the cell at the tableviewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "jumpToDetail", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jumpToDetail",
           let destinationVC = segue.destination as? DetailsViewController,
           let indexPath = sender as? IndexPath {
            let selectedMovie = filteredMovies[indexPath.row]
            destinationVC.movieID = selectedMovie["imdbID"] as? String
        }
    }


    //Search bar conditioning
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            //If Search Text is empty then show all movies
            filteredMovies = movies
        } else {
            //filter movies based on searching
            filteredMovies = movies.filter { movie in
                let title = movie["Title"] as? String ?? ""
                return title.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

