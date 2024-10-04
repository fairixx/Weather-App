# Weather App Documentation

## Overview
This documentation provides an overview of the Weather App built using Flutter with the GetX state management pattern, incorporating clean code principles, routing, animations, and real-time data from the OpenWeather API. The application enables users to select a location and view detailed weather information including temperature, humidity, wind speed, maximum temperature, and forecasts for the coming days.

## Features
- **Real-time Weather Data**: Fetches current weather and forecasts using the OpenWeather API.
- **Location Selection**: Allows users to select a location for which to display weather information.
- **Detailed Weather Metrics**:
  - Current temperature
  - Humidity levels
  - Wind speed
  - Maximum temperature
  - Forecast for upcoming days with date and time.
- **Responsive Design**: Adapts to various screen sizes for a seamless user experience.
- **Animations**: Provides a smooth and engaging user experience with animated transitions.

## Technologies Used
- **Flutter**: UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **GetX**: A powerful and lightweight solution for state management, dependency injection, and route management.
- **OpenWeather API**: A RESTful API that provides weather data, allowing real-time access to current and forecasted weather conditions.

##ScreenShots

## User Interface Layout
Below is the UI implementation for local storage using SharedPreferences:
<table>
    <tbody>
        <tr>
			<th>Local Storage With SharedPreferences</th>	
		</tr>
        <tr>
			<td>
				<img width="280" height='500' alt="img1" src="https://github.com/fairixx/Weather-App/blob/main/screenshots/1.png">
				<img width="280" height='500' alt="img1" src="https://github.com/fairixx/Weather-App/blob/main/screenshots/2.png">
				<img width="280" height='500' alt="img1" src="https://github.com/fairixx/Weather-App/blob/main/screenshots/3.png">
				<img width="230" height='500' alt="img1" src="https://github.com/fairixx/Weather-App/blob/main/screenshots/4.png">
				<img width="230" height='500' alt="img1" src="https://github.com/fairixx/Weather-App/blob/main/screenshots/5.png">
			</td>
		</tr>
        <tr>
			<td align="center">
				<a href="https://github.com/fairixx/Weather-App">
					<img src="https://github-readme-stats.vercel.app/api/pin/?username=fairixx&repo=Weather-App&theme=dracula" alt="local Storage" />
				</a>
			</td>
		</tr>
    </tbody>
</table>


## Setup Instructions

### Prerequisites
- Flutter SDK
- Dart SDK
- IDE (e.g., Android Studio, Visual Studio Code)
- Git

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/fairixx/Weather-App.git
   cd Weather-App
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Obtain OpenWeather API Key**:
   - Sign up at [OpenWeather](https://openweathermap.org/) and get your API key.
   - Replace `YOUR_API_KEY` in the code with your actual API key.

4. **Run the App**:
   ```bash
   flutter run
   ```

## Code Structure
- **lib/**: Contains the main application code.
  - **controllers/**: Houses the GetX controllers for state management.
  - **models/**: Data models for parsing the weather data.
  - **views/**: UI components for displaying the weather data.
  - **routes/**: Defines the application routes.
  - **services/**: Contains API service classes for fetching weather data.

## GetX State Management
Utilizes GetX for:
- **State Management**: Handles the application state in a reactive manner.
- **Dependency Injection**: Instantly injects dependencies where needed.
- **Route Management**: Simplifies navigation and routing between different views.

### Example Controller
```dart
class WeatherController extends GetxController {
  var weatherData = WeatherModel().obs;

  Future<void> fetchWeather(String location) async {
    // Fetch weather data from OpenWeather API
    // Update weatherData with the response
  }
}
```

## Routing
The application uses GetX for routing to enable smooth transitions between screens.

### Example Route
```dart
Get.to(() => WeatherDetailScreen(location: selectedLocation));
```

## Animations
Animations are implemented using Flutter’s built-in animation libraries to enhance user experience.

### Example Animation
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: // Your widget here
)
```

## Responsive Design
The app utilizes Flutter's layout features to ensure a responsive design across various devices.

### Example Responsive Widget
```dart
if (MediaQuery.of(context).size.width > 600) {
  // Display tablet layout
} else {
  // Display mobile layout
}
```

## Conclusion
This Weather App effectively demonstrates how to implement Flutter with GetX for state management and real-time weather data fetching. It follows clean code principles and provides a responsive design, ensuring a great user experience.

---
