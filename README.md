# TheMovieApp

## Description

An application that uses the [TMDB](https://developers.themoviedb.org/3/getting-started/introduction) database that allows users to browse, search and save movies. In addition, the app recommends movies to watch based on the user's saved ratings of other movies and the user's favorite actors.

## Requirements

iOS 13.0

Xcode 13.2

macOS 11.3 Big Sur 

To run the application, clone the project from repository to Xcode and run on simulator


## Used in the app

Swift, SwiftUI, Swift Concurrency, Combine, Core Data, REST API, MVVM design pattern

## Features

The application allows to:

Browse the most popular and top-rated movies from the TMDB database.

![browse-popular-movies](https://github.com/Belijder/TheMovie_App/blob/master/BrowsePopular.gif)

Search the database for a specific movie.

![search-movie](https://github.com/Belijder/TheMovie_App/blob/master/BrowseTopRated.gif)

Save the movies that users want to watch, save their favorite actors, and rate the videos they've watched. 
That data is stored in the device memory by using Core Data.

![saved-items](https://github.com/Belijder/TheMovie_App/blob/master/SavedItems.gif)

Based on the user's film ratings and saved favorite actors, the app recommends films that may be of interest to the user.

![recommendation1](https://github.com/Belijder/TheMovie_App/blob/master/YouMightAlsoLike.gif)

## User Interface
The UI of the app tries to imitate the UI of an existing app from the AppStore called IMDb.
