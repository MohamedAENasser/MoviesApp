# Welcome to MoviesApp application.

By using this application, you will be able to find and search for the movies and getting the full details of your favorite movies.

Here are the hight level steps followed while implementing the application:

- Checked the EndPoint response and created the Model based on needed data.
- For Networking used Moya framework, which is using Alamofire logic under the hood and adding a higher level of enums to facilitate dealing with multiple endpoints, also it provides easy handling for stub files which is used in unit testing. 
- Created a Service classes for home screen and movie details screen to handle APIs calls which will be injected to the ViewModel.
- Created an Image loader class which is responsible for donloading and caching images with the specified resolution.
- The architecture used is MVVM, used it since ViewModel is pure logic and it’s not coupled with the view code, this will helps on clean visibility and separation of the logic behavior and helps a lot with adding tests to the app.
- Used Async Await methodology in the ViewModel to fetch the available movies data and movie details from the service object then working on that data to properly display it.
- Used Combine in many places like view models and view controllers to handle binding logic and update the presented data accordingly.

- Created multiple screens for the application flow as follows:
	- `Home Screen`: A collection view contains the main screen UI to start the app with, it can presnet different options either `loading`, `success` or `failure`.
    
      There are two availabe styles can be applied on main screen cells, this can be configured by the button above the collection which has the icon determining the avilable option:
    	- List: which uses the `HomeScreenEnlargedCell`, this style is showing the moveis as list, one cell per row.
    	- Combact: which uses the `HomeScreenCompactCell`, this style is showing the moveis as collection with two movies per row.
      - At the end of the page, a `LoadingCell` will appear automatically to fetch the next page of the movies through the API, if we already reached the max page, then this cell won't show.
  - `Movie Details Screen`: A ViewController `MovieDetailsViewController` which is pushed on home screen when a specific movie is selected, calling the API to get the movie details then presnet its data.
  - `Shimmer`: A Shimmer view is created specifically for each screen to coreespond the expected data and used the generic `ShimmerView` component to have the consistent loading animation through the whole application, will be shown once a service is started like getting movies data or getting movie details data.
    	- Added shimmer views for `HomeScreenEnlargedShimmerCell`, `HomeScreenCompactShimmerCell`, `MovieDetailsViewController`
    	- Add a separate shimmer for image view in both (cells and movie details) imageViews as the image has its own API call and maybe finished later then the normal call.
	- `ErrorView`: A view that will appear if there is an error occurred while fetching the data, giving the user an option to retry fetching the data by tapping on retry button.
     	- Created Error Cell that will appear on the home screen if an error occured.
    	- Created Error View that will appear on the movie details screen if an error occured.

- Added unit testing to test the full logic used in home screen, 
	- Used Moya's sample data to simulate stub data needed for the unit tests and added full tests to make sure that the data is properly handled from fetching to presentation.

*Troubleshooting Notes:*
- To run the application properly and get data, Update the `API_KEY` withe a vaild key, this can be found in `MoviesTarget` file, the property is named `apiKey`.
- run `pod install`
- Select the correct `MoviesApp` app scheme 
