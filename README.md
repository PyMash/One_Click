# One_Click 
An On-Demand Service System Using Flutter & Firebase
## How to Download and Run the File.
*1. Goto Code and Download Zip <Br>*
*2. Extract the Folder </Br>*
*3. Rename the Folder "One_Click-main" as "one_click" <Br>*
*4. Open the folder in VS Code and Change the Directory to the root of the flutter project </Br>*
*5. Run 'Flutter Clean' and 'Flutter pub get' in the Terminal </Br>*
*6. Ctrl+Shift+p and type 'Flutter: Select Device' > Select 'Enable Android for this project' and > 'Yes' to the dialog box </Br>*
*7. Now make a new Android Firebase Project > Android package name: "com.example.one_click" > Register the App > Download "google-services.json" > Copy and Paste this file inside App folder (path: android/app) </Br>*
*8. Add Firebase SDK by editing the build.gradle file inside (path: android/build.gradle) > Add (classpath 'com.google.gms:google-services:4.3.15') after line.10 </Br>*
*9. Now editing the build.gradle file inside (path: android/app/build.gradle) > line.11 Change "throw new GradleException" to "throw GradleException" > Add (apply plugin: 'com.google.gms.google-services') after line.26 > Add (implementation platform('com.google.firebase:firebase-bom:32.1.1')) after line.71 > And Change 'minSdkVersion 19' in line.51 </Br>*
*10. In the Firebase project goto Build > Authentication > Sign-in method > Email/Password enable 'Email/Password' only and Save.</Br>*
*11. In the Firebase project goto Build > Firestore Database > Start in test mode > Cloud Firestore location: 'asia-south1 (Mumbai)' only When you are from India > Click Enable</Br>*
*12. To Enable multidex support run 'flutter run --debug' in the terminal > App will be running in the Android Emulator > Make a new account and Explore </Br>*
