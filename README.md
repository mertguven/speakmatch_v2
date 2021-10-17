<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/mertguven/speakmatch_v2">
    <img src="assets/images/active_bnb_logo.png" alt="Logo" width="30%">
  </a>

  <h1 align="center">SpeakMatch</h1>

  <p align="center">
    Speakmatch is a video, audio and chat application!
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#project-structure">Project Structure</a></li>
    <li><a href="#packages">Packages</a></li>
    <li><a href="#design-pattern">Design Pattern</a></li>
    <li><a href="#descriptions-of-project-files">Descriptions Of Project Files</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>


<div id="built-with"></div>

## Built With

* [Flutter](https://flutter.dev/)
* [Dart](https://dart.dev/)
* [Firebase](https://firebase.google.com/)


<div id="project-structure"></div>

## Project Structure

<pre>
├── android
├── assets
│   ├── animations
│   └── images
├── ios
├── lib
│   ├── controller
│   ├── core
│   │   ├── constants
│   │   ├── theme
│   │   └── utilities
│   ├── cubit
│   ├── data
│   │   ├── model
│   │   ├── repositories
│   │   └── service
│   ├── presentation
│   │   ├── authentication
│   │   ├── main
│   │   │   ├── home
│   │   │   ├── messages
│   │   │   └── profile
│   ├── main.dart
│   └── shared-prefs.dart
├── pubspec.lock
└── pubspec.yaml
</pre>

<div id="packages"></div>

## Packages

* Default Package
  * [cupertino_icons](https://pub.dev/packages/cupertino_icons/)
* Data Logging Package
  * [shared_preferences](https://pub.dev/packages/shared_preferences/)
* State Management Package
  * [flutter_bloc](https://pub.dev/packages/flutter_bloc/)
* Firebase Packages
  * [firebase_auth](https://pub.dev/packages/firebase_auth/)
  * [firebase_core](https://pub.dev/packages/firebase_core/)
  * [cloud_firestore](https://pub.dev/packages/cloud_firestore/)
  * [google_sign_in](https://pub.dev/packages/google_sign_in/)
* Presentation Packages
  * [google_fonts](https://pub.dev/packages/google_fonts/)
  * [get](https://pub.dev/packages/get/)
  * [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter/)
  * [persistent_bottom_nav_bar](https://pub.dev/packages/persistent_bottom_nav_bar/)
  * [avatar_glow](https://pub.dev/packages/avatar_glow/)
  * [flutter_easyloading](https://pub.dev/packages/flutter_easyloading/)


<div id="design-pattern"></div>

## Design Pattern
The design pattern of the project is [MVC](https://en.wikipedia.org/wiki/Model–view–controller).


<div id="descriptions-of-project-files"></div>

## Descriptions Of Project Files

<b>assets/ :</b>
  <p>This folder is the folder where the asset files of the project are located.</p>
<b>assets/images/ :</b>
  <p>This folder is the folder where the image files of the project are located.</p>
<b>assets/animations/ :</b>
  <p>This file is the file containing the animation files of the project.</p>
<b>lib/ :</b>
  <p>It's the section where the source code of the project is located.</p>
<b>lib/controller/ :</b>
  <p>It's the section that controls the business processes of the project.</p>
<b>core/ :</b>
  <p>It's the section where the core folders of the project are located.</p>
<b>core/constants/ :</b>
  <p>It's the section where the constants of the project are located.</p>
<b>core/theme/ :</b>
  <p>It's the section where the theme of the project is located.</p>
<b>core/utilities/ :</b>
  <p>It's the section where the custom widgets used throughout the project are located.</p>
<b>cubit/ :</b>
  <p>It's the section where the state management of the project is located.</p>
<b>data/ :</b>
  <p>It's the data layer of the project.</p>
<b>data/model :</b>
  <p>It's the part of the project where the models of the data coming from the firebase are located.</p>
<b>data/repositories :</b>
  <p>It's the part of the project where the data from the service layer is transformed into models and sent to the controller layer.</p>
<b>data/service :</b>
  <p>It's the part that communicates with Firebase.</p>
<b>presentation/ :</b>
  <p>It's the presentation layer of the project.</p>
  

<div id="license"></div>

## License

<pre>
Copyright 2021 MERT GÜVEN

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
</pre>


<div id="contact"></div>

## Contact

* Mert Güven - [mertguven.com](http://mertguven.com/#/) - mertguven789@gmail.com
* Doğukan Yolcuoğlu - [@dogukanyolcuoglu](https://github.com/dogukanyolcuoglu) - dogukan.yolcuoglu09@gmail.com
* Eray Hamurlu - [erayh.com](http://erayh.com) - hamurlueray@gmail.com



<p align="right"><a href="#top">⬆️</a></p>
