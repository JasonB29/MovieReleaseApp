# MovieReleaseApp
SwiftUI app that utilises a network call to access a TMDB web service, the data is then parsed into Codable structs and saved to a CoreData database.

This app displays the upcoming movies with their associated poster images in a list view. The user is able to click on the image which then navigates to a new movie detail view.
The detail view provides a synopsis of the movie plus an option for the user to 'favourite' the movie, which in turn saves the movie to a favourites list that can  be viewed using the favourites tab at the bottom of the screen.



# Pre-requisites

1. XCode and XCode simulator are needed to run this application.
2. A TMDB API Key is needed in order for the network call to work properly, as TMDB requires the key to be sent in the HTTP request for the service to work properly. Once you have signed up for an account, the following link provides instructions on how to obtain an API Key: https://developers.themoviedb.org/3/getting-started/authentication
3. Once an API Key is obtained, copy and paste into the 'Settings' page and the key will be saved for future use on your device.

 <img width="500" alt="SettingsView" src="https://user-images.githubusercontent.com/37980812/137292853-c1bb9f7f-126a-470a-8fe8-3e8403135edd.png">




# Screen Shots

<img width="500" alt="ReleaseDatesView" src="https://user-images.githubusercontent.com/37980812/137292811-5c755c64-8068-45b3-9d81-6a6a6794bc90.png">

<img width="500" alt="DetailView" src="https://user-images.githubusercontent.com/37980812/137292913-7ab065b3-879f-4b6b-a729-4be9ace62177.png">

<img width="500" alt="FavouritesView" src="https://user-images.githubusercontent.com/37980812/137292937-b4d5ac77-3737-4f54-809d-c11ff1d589c0.png">


# Testing

Unit tests and UI Tests have been created for the application, all tests utilise XCodes's XCTest Class.

