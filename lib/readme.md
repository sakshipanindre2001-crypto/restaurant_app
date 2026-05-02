 Restaurant App (Flutter)

This is a simple Flutter app to display a list of restaurants.
It has a clean UI, loads images, and handles errors properly.


 Features

 Display list of restaurants
 Load images from network
 Show error message if something fails
 Retry button to try again
 Simple and reusable UI
 Smooth navigation between screens



 Environment Details

 Flutter: 3.35.7
 Dart: 3.9.2
 Gradle: 8.12
 Android Gradle Plugin: Managed by Flutter
 JDK: 17
 Minimum SDK: 23
 Target SDK: 34
 Build Variant: Release



 Project Structure


lib/
  model/
    restaurant_entity.dart
     restaurant_detail_entity.dart

  widgets/
    restaurant_card.dart
    error_msg.dart
    

  screens/
    restaurant_list_screen.dart
    restaurant_detail_screen.dart
    

  main.dart
```

---

Error Handling

The app uses a reusable widget called ErrorFallback.

 Displays an error message
 Provides a retry button


```



