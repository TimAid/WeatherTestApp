# WeatherTestApp

WeatherApp is a simple, yet playful app built with UIKit! It's my personal project that I decided to make public so that anyone can check out the trials and tribulations I had to go through and am still going through to build test app on UIKit. Hope you enjoy.


Here are some screenshots of the current develop version. 


**Some Highlights of the App:**

<img src="https://user-images.githubusercontent.com/88784467/217459174-e6297046-c8bd-4e55-a45f-edb18f39e735.png" width="300" height="500"><img src="https://user-images.githubusercontent.com/88784467/217459181-2300cc7f-3d0f-48c1-95e6-d26d606f7c96.png" width="300" height="500"><img src="https://user-images.githubusercontent.com/88784467/217493256-d8cc07a6-484f-4aad-a87d-8f583d84a26c.png" width="300" height="500">
<img src="https://user-images.githubusercontent.com/88784467/217459190-0303b0fa-4d33-4e3d-9831-6ff5b77af8bb.png" width="300" height="500"><img src="https://user-images.githubusercontent.com/88784467/217459192-1e0c5427-0ac9-4854-a284-c38cca55810c.png" width="300" height="500">


**1. API**

WeatherApp uses the Yandex Weather API to display weather data to users. 

**2. Networking**

The networking layer was done without using any third party libraries, using the good old URLSession. I created a NetworkManager to take care of creating data tasks and retrieving data received from requests. A service class was also created to interface with the client. It initiates requests specific to Yandex Weather API and returns data that it subsequently turns into models readable by the UI layer.

**3. Core Location**

In order to transform human readable addresses into geographic coordinates (latitude/longitude) I used Apple's CLGeocoder which is part of the Core Location library. This allowed me to retrieve coordinates which were then used as parameters in my web requests to the Yandex Weather API

**4. SwiftSVG**

I fecth weather icons from Yandex Weather API. It's svg file. So that I used SwiftSVG to input icon in UIView. 

**5. Search Controller** 

I add Seacrh Controller to find already saved cities. 
