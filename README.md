# FlutterClientNodeServer
Making Bind between flutter as a client and Node as backend.

## To run this example
+ Clone this repo
+ Go to the server folder
+ run npm install
+ *run npm start and keep it running*
+ open the Flutter folder
+ Run flutter packages get
+ **Place your own IP at the server url API calls at the login_screen.dart**
+ run flutter run

## To play with JWT token and HTTP verbs
The first verb to execute is POST, due to that, at onPressed callback of the submitButton Widget, the method doPost() is uncommented. 
After you run that login, comment that line, and uncommented the next one, doGet(), and them the same for doPatch()




