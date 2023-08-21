
# <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/swift/swift-original.svg" height="40" width="40">  Virtual Tourist

Welcome to Virtual Tourist – your passport to exploring the world through photos! Immerse yourself in a captivating journey of discovery as you venture into different corners of the globe, dropping pins on maps to mark intriguing spots and unveiling a treasure trove of captivating images.




## User Storie



```bash
As a user of the Virtual Tourist app, 
I want to be able to explore different locations on a map, 
drop pins on the map to mark interesting spots, 
view photos associated with each pinned location, 
and have the ability to refresh the photos collection for each location.
```


## Installation Instructions
To install and set up Virtual Tourist, follow these steps:
- Clone or download the project from the GitHub repository https://github.com/joao-ponte/VirtualTourist.
- Open the project in Xcode.
- Build and run the app on a simulator or a physical device running iOS 16.3 or higher.

## Usage Instructions
To use the On The Map app, follow these steps:
- Launch the app on your iOS device.

- Explore the Map: When you open the app, you'll find yourself on a map interface. Use familiar pinch and swipe gestures to zoom in, zoom out, and pan around. This is your canvas for marking and discovering new locations.

- Drop Pins: To mark a spot that catches your interest, simply perform a long press on the map. A pin will appear at the location you pressed. Each pin represents a destination you'd like to learn more about.

- View Photo Galleries: Tapping on a pin will take you to a photo gallery specific to that location. Here, you'll find a collection of captivating images sourced from the Flickr API. Scroll through the images to immerse yourself in the beauty of each location.

- Refresh Photo Collections: Excited to see more images? Tap the "New Collection" button in the photo gallery to refresh the images for that specific location. Each tap unveils a new set of photos for your viewing pleasure.

- Persist Memories: As you explore, Virtual Tourist keeps track of your journey. Pins you drop and images you view are safely stored using Core Data. This way, your unique travel experiences are always within reach.


## Features
The Virtual Tourist app provides the following features:
- Map Exploration: The app provides a map interface using the MapKit framework. Users can zoom and pan around the map to explore different areas.

- Adding Pins: Users can drop pins on the map by performing a long press on the desired location. Each pin marks a location of interest.

- Viewing Photos: When a pin is tapped, the app transitions to a photo gallery view associated with that pin's location. The photo gallery displays a collection of images fetched from the Flickr API based on the pin's coordinates. Users can scroll through the images in the gallery.

- Refreshing Photos: Users can refresh the photos collection for a specific pin by tapping a "New Collection" button. This action triggers the app to fetch a new set of images from the Flickr API and update the photo gallery.

- Data Persistence: Pins and associated photos' metadata are stored using COREDATA. The app stores information about pins' coordinates, images' URLs, and other relevant data.

## Technologies Used
The Virtual Tourist app is built using the following technologies and tools:
- Swift: The app is developed using the Swift programming language.

- MVVM Architecture: The app follows the Model-View-ViewModel (MVVM) architectural pattern to separate concerns and improve maintainability.

- MapKit: The MapKit framework is used for displaying the map interface, adding pins, and handling user interactions.

- Core Data: The app utilizes Core Data to manage and persist data, including pins' coordinates and photo metadata.

- Flickr API Integration: The app fetches photos from the Flickr API using API requests to populate the photo gallery associated with each pin.

- UIKit: The app's user interface is built using UIKit components, including view controllers, collection views, and navigation controllers.

- Networking: Networking operations are handled using URLSession to make API requests and download image data from remote sources.

- User Defaults: User Defaults is used to store user preferences, such as map region and last viewed position.

- Gesture Recognizers: Long press gesture recognizer is used to enable users to drop pins on the map.

- Multithreading: Grand Central Dispatch (GCD) is employed for performing background tasks, such as downloading images from the internet and managing concurrency.

- Storyboard and Interface Builder: The app's user interface is designed using Storyboards and Interface Builder within Xcode.

- UIKit Components: The app uses various UIKit components, such as buttons, collection views, and map views, to create a cohesive user experience.
## Screenshots
## Authors

- [@Joao Ponte](https://www.linkedin.com/in/jponte/)

