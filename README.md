# myMovies
**App Icon of myMovies**

![1](https://github.com/user-attachments/assets/17078615-ad3c-49ec-93f4-df18da1ff37f)

**myMovies Splash Screen**
![2](https://github.com/user-attachments/assets/9172e6b3-bbfb-492e-b79b-3759140d5d6a) 

**myMovies main Screen**
![3](https://github.com/user-attachments/assets/0f19c62e-1561-4fcf-8a16-3beacd157592)

**marking movie as Favourite**
![4](https://github.com/user-attachments/assets/3f5dfa31-3b8d-46e0-9898-5c006f7221c5)

**Details of selected movie**
![5](https://github.com/user-attachments/assets/c4863552-e15a-4429-b6d5-7d2cc19e8804)

![image](https://github.com/user-attachments/assets/ca945606-0a90-4ff4-b0f9-4268bb26061c)


**Searching the movie in main Screen**
![6](https://github.com/user-attachments/assets/ed601b8e-83d2-44fa-ad93-e1115c61c41b)

Setting Up The Project
1.) Since we are using APIS of OMDB  we should obtain a key for accesing API data.

2.) So We will get our API key through email registration from OMDB website https://www.omdbapi.com/apikey.aspx

3.) After getting the key we can get the movie details through the link like this for example https://www.omdbapi.com/?apikey=9e96a71f&type=movie&s=Don can get movie details of the Movie Don

4.) Now Registration of API is completed.

5.) So we need to create new Project in Xcode and suppose name it as "myMovies" and we must select include Tests

6.) Now Project is created Successfully

7.) The next step we should create splash screen that shows appLogo for 3 Seconds before navigating to the main Screen

8.) we will setup the Required UI in the ViewController of the Project , considering placing the logo in the middle of the storyboard and changing the background

![splashScreen](https://github.com/user-attachments/assets/bd33a150-60cc-48c4-851d-2c985efa7a3a)

9.) So UI Setting up for splash Screen is completed.Now will select new viewController from the Library and place it on the Storyboard

10.) and for that ViewController  say "MainViewController " we wil we will link that view controller through storyboard

11.) and we will place UISearchBar and UItableview from Library and give appropiate layouts

![mainViewCOntroller](https://github.com/user-attachments/assets/81987560-e33d-45fc-8402-a6f17a95b096)



12.) Now we will create Xib file for the tableviewcell and places the UIImage for poster,label for title&release year and heart symbol for favourites with appropriate autolayouts

![TableViewCell](https://github.com/user-attachments/assets/78822734-1b98-46a1-ba18-62f617d4e14c)




13.) When the favorite button is tapped, the favouriteButtonTapped method toggles the movie's favorite status and saves it using UserDefaults.

14.) The configure method sets up the cell with movie data, including downloading and setting the poster image asynchronously. 

15.) The cell's background and text colors are set to ensure good contrast and readability.

16.) Coming back to MainViewController we will setup all the required things setiing up basic things like conform to UITableVIewDataSource and UITableViewDelegate

17.) and then we will register Tableviewcell in this mainViewController, and the class maintains arrays for movies and filtered results, and tracks the search state with a boolean variable. In viewDidLoad(), it sets up the table view and search bar, registers a custom cell, and initiates fetching movie data from the OMDb API.

18.) The fetched data is parsed and used to update the table view on the main thread. The search bar's appearance is customized, and it filters the movie list based on user input. The navigation bar's appearance is set programmatically in viewWillAppear()

19.) The class also handles URL session tasks for API data fetching, with appropriate error handling and JSON parsing to extract movie data. The searchBarDelegate methods manage search input and keyboard dismissal, ensuring a responsive and user-friendly interface.

20.) And we will create DetailsViewController , similar process above mentioned for creating a UIViewController .

21.) And then we will implement the ScrollView on the viewcontroller with appropritate Layouts

22.) And then place the UIComponents titleLabel,yearLabel,actors,genreLabel,languageLabel,ratingLabel,worthWatchingLabel & plot and director label as UITextView & posterImageview as UIImageView with appropriate constraints

23.)and when clicked on cell in tableviewcells that particular movie imdbID is passed to detailsViewController's movieID

24.) In detailsViewController's viewDidLoad function fetchMovieDetails(movieID:) is called and fetches movie details from the OMDb API and parses the JSON response.

25.) The updateUI(with:) function updates the UI components with the parsed movie details.

