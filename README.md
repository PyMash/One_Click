# One_Click | AN ON-DEMAND SERVICE SYSTEM USING FLUTTER & FIREBASE
Semester Project

## How to Download and Run the File.
*1. Goto Code and Download Zip </Br>*
*2. Extract the Folder </Br>*
*3. Rename the Folder "One_Click-main" as "one_click" <Br>*
*4. Open the folder in VS Code and Change the Directory to the root of the flutter project </Br>*
*5. Run 'Flutter Clean' and 'Flutter pub get' in the Terminal </Br>*
*6. Ctrl+Shift+p and type 'Flutter: Select Device' </Br> Select 'Enable Android for this project' and </Br> 'Yes' to the dialog box </Br>*
*7. Now make a new Android Firebase Project </Br> Android package name: "com.example.one_click" > Register the App </Br> Download "google-services.json" </Br> Copy and Paste this file inside App folder (path: android/app) </Br>*
*8. Add Firebase SDK by editing the build.gradle file inside (path: android/build.gradle) </Br> Add (classpath 'com.google.gms:google-services:4.3.15') after line.10 </Br>*
*9. Now editing the build.gradle file inside (path: android/app/build.gradle) </Br> line.11 Change "throw new GradleException" to "throw GradleException" </Br> Add (apply plugin: 'com.google.gms.google-services') after line.26 </Br> Add (implementation platform('com.google.firebase:firebase-bom:32.1.1')) after line.71 </Br> And Change 'minSdkVersion 19' in line.51 </Br>*
*10. In the Firebase project goto Build > Authentication > Sign-in method > Email/Password enable 'Email/Password' only and Save.</Br>
*11. In the Firebase project goto Build > Firestore Database > Start in test mode > Cloud Firestore location: 'asia-south1 (Mumbai)' only When you are from India > Click Enable.
*12. To Enable multidex support run 'flutter run --debug' in the terminal </Br> App will be running in the Android Emulator </Br> Make a new account and Explore </Br>*
