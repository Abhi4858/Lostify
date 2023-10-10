import 'package:flutter/material.dart';
import 'package:lostify/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostify/screens/Lost%20Section/lost_section.dart';
import '../utils/utilities.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginEmailController.dispose();
    loginPassController.dispose();
    // disposing these controllers when they won't be needed after exiting from this login screen
  }

  void login(){
    _auth.signInWithEmailAndPassword(email: loginEmailController.text.toString(), password: loginPassController.text.toString()).then((value){
      Utils().toastMessage(value.user!.email.toString());
      setState(() {
        loading = false;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LostSection()));
      });
    }).onError((error, stackTrace){

      // treating as commented lines of code when app in debugging phase
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // when onscreen keyboard appears then avoid resizing the scaffold
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed: (){
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_ios,
        //     size: 20,
        //     color: Colors.black,),
        // ),
      ),

      body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Login" , style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),),

                        SizedBox(
                          height: 20,
                        ),

                        Text("Login to your account" , style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),)
                      ],
                    ),

                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            inputFile1("Email"),
                            inputFile2("Password"),
                          ],
                        )
                    ),

                    Container(
                      width: 310,
                      padding: EdgeInsets.only(top: 3 , left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )
                      ),

                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.pink.shade800,
                        elevation: 0,
                        onPressed: (){
                          if(_formKey1.currentState!.validate() && _formKey2.currentState!.validate()){
                            setState(() {
                              loading = true;
                            });
                            login();
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),

                        child: Text("Login" , style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),),
                      ),
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? " , style: TextStyle(
                            fontSize: 15,
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(left: 2 , bottom: 1.5),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                              },
                              child: Text("Sign up" , style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                          ),
                        ]

                    ),

                    Container(
                      padding: EdgeInsets.only(top: 100),
                      height: 150,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                          image: DecorationImage(
                            image: AssetImage('lib/assets/loginPage.png'),
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  Widget inputFile1(String title){
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(title , style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87
            ),),
          ),

          SizedBox(height: 5,),

          TextFormField(
            obscureText: false,
            controller: loginEmailController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0 , horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.pink.shade800,
                  width: 2,
                ),
              ),

              prefixIcon: assignIcon(title),
            ),

            validator: (value){
              if(value!.isEmpty){
                return validateToast(title);
              }
              else return null;
            },
          ),

          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget inputFile2(String title){
    return Form(
      key: _formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(title , style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87
            ),),
          ),

          SizedBox(height: 5,),

          TextFormField(
            obscureText: true,
            controller: loginPassController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0 , horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.pink.shade800,
                  width: 2,
                ),
              ),

              prefixIcon: assignIcon(title),
            ),

            validator: (value){
              if(value!.isEmpty){
                return validateToast(title);
              }
              else return null;
            },
          ),

          SizedBox(height: 10,),
        ],
      ),
    );
  }

  TextEditingController assignController(String title){
    if(title == "Email"){
      return loginEmailController;
    }
    return loginPassController;
  }

  Key assignFormKey(String title){
    if(title == "Email"){
      return _formKey1;
    }
    return _formKey2;
  }

  String validateToast(String title){
    if(title == "Email"){
      return "Enter email";
    }
    return "Enter password";
  }

  Icon assignIcon(String title){
    if(title == "Email"){
      return Icon(Icons.email , color: Colors.pink.shade800,);
    }
    return Icon(Icons.password , color: Colors.pink.shade800,);
  }

}


