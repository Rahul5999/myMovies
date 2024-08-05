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

12.) Now we will create Xib file for the tableviewcell and places the UIImage for poster,label for title&release year and heart symbol for favourites with appropriate autolayouts

13.) When the favorite button is tapped, the favouriteButtonTapped method toggles the movie's favorite status and saves it using UserDefaults.

14.) The configure method sets up the cell with movie data, including downloading and setting the poster image asynchronously. 

15.) The cell's background and text colors are set to ensure good contrast and readability.

16.) Coming back to MainViewController we will setup all the required things setiing up basic things like conform to UITableVIewDataSource and UITableViewDelegate

17.) and then we will register Tableviewcell in this mainViewController
