# Flutter Taxi App UI Kit
Clone this repository. Open the code folder in any IDE you want
1. Get Google Map API:
	- Log in to the Google API Manager Console here: https://console.developers.google.com/apis/library
	- Enable service on https://console.developers.google.com/apis/library?filter=category:maps
		- Directions API
		- Distance Matrix API
		- Maps SDK for Android
		- Maps SDK for IOS
	- Click the Library link in the left sidebar
	- Select the project you created when you created your API Key for WP Google Maps (See the top arrow in the screenshot below)
	- Click the link to the Google Maps Directions API in the listing under Google Maps APIs. (See bottom arrow in screenshot below.)
	- Click Enable on the Google Maps Directions API window.

	- Click the Credentials link in the left sidebar
	- Click the Create credentials to get new API KEY
2. After acquiring Google Map Api, insert  Google Map Api Key to some file:
	- Androids
		- android/app/src/main/AndroidManifest.xml
	- Ios
		- ios/Runner/AppDelegate.swift
	- lib/config.dart
		- ApiKey: your google map api key
		- language: your language code
		- region: your region
> (Read more documents: https://developers.google.com/places/web-service/search)

3. Run get packages
```flutter packages get```
4. Connect your phone to a computer, or open a simulator and run
```flutter clean```
```flutter run```
	- For ios, you run more commands:
```cd ios```
```pod install```
```pod update```
	- And run again project

# Features
**
Flutter Taxi App UI Kit communicates with the Google Maps API Directions Service which receives direction requests and returns an efficient path. The application works on iOS and Android**
- Draw the shortest path between 2 points on the map
- Real-time tracking of driver's location (New)
- Filter and display markers around your current location (New)
- Select start position and end position directly on the map
- Calculate distance, cost, time of the route
- 25+ Screens
- Clean code easy develop
- Using Animation Controller
- Responsive Design to any all device screen
- Easy to Custom layout
- Using mvc model, blocs
