import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lostify/auth/login_screen.dart';

import '../utils/utilities.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  // bool loading = false;

  void signUp(){
    if(_formKey1.currentState!.validate() && _formKey2.currentState!.validate()){
      _auth.createUserWithEmailAndPassword(email: signUpEmailController.text.toString(), password: signUpPasswordController.text.toString()).then((value){
        Utils().toastMessage("New account successfully created");
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }).onError((error, stackTrace){
        Utils().toastMessage(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false, // when onscreen keyboard appears then avoid resizing the scaffold
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.sizeOf(context).height-50,
          width: double.infinity,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Sign Up" , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),),

                  SizedBox(
                    height: 20,
                  ),

                  Text("Create an account, it's free" , style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                  ),)
                ],
              ),
              Column(
                children: [
                  inputFile1(label: "Email"),
                  inputFile2(label: "Password" , obscureText: true),
                ],
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
                    signUp();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),

                  child: Text("Sign Up" , style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? " , style: TextStyle(
                    fontSize: 15,
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left: 2 , bottom: 2.5),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text("Log in" , style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                padding: EdgeInsets.only(top: 100),
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/welcome2.png'),
                    )
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController assignController(String title){
    if(title == "Email"){
      return signUpEmailController;
    }
    return signUpPasswordController;
  }

  Widget getPrefixIcon(String label){
    if(label == "Email") return Icon(Icons.email , color: Colors.pink.shade800,);
    return Icon(Icons.password , color: Colors.pink.shade800,);
  }

  GlobalKey<FormState> assignFormKey(String title){
    if(title == "Email"){
      return _formKey1;
    }
    return _formKey2;
  }

  Widget inputFile1({label , obscureText = false}){
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(label , style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87
            ),),
          ),

          SizedBox(height: 5,),

          TextFormField(
            controller: signUpEmailController,
            obscureText: obscureText,
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

              prefixIcon: getPrefixIcon(label),
            ),
            validator: (value){
              if(value!.isEmpty){
                return "Enter email";
              }
              else return null;
            },
          ),

          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget inputFile2({label , obscureText = false}){

  return Form(
    key: _formKey2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(label , style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black87
          ),),
        ),

        SizedBox(height: 5,),

        TextFormField(
          obscureText: obscureText,
          controller: signUpPasswordController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0 , horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),

            // border: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.grey.shade400),
            //   borderRadius: BorderRadius.circular(10),
            // )
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.pink.shade800,
                width: 2,
              ),
            ),

            prefixIcon: getPrefixIcon(label),
          ),

          validator: (value){
            if(value!.isEmpty){
              return "Enter password";
            }
            else return null;
          },
        ),

        SizedBox(height: 10,),
      ],
    ),
  );
}

}

//
//
//
//

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lostify/auth/login_screen.dart';
// import 'package:lostify/auth/round_rectangle_border.dart';
//
// import '../utils/utilities.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => SignUpScreenState();
// }
//
// class SignUpScreenState extends State<SignUpScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool loading = false;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     // disposing these controllers when they won't be needed after exiting from this login screen
//
//   }
//
//   void signUp(){
//     if(_formKey.currentState!.validate()){
//       setState(() {
//         loading = true;
//       });
//       _auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
//         setState(() {
//           loading = false;
//         });
//       }).onError((error, stackTrace){
//         Utils().toastMessage(error.toString());
//         setState(() {
//           loading = false;
//         });
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign Up"),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.person),
//                         hintText: "Email",
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                               color: Colors.blue,
//                               width: 2,
//                             )
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                               color: Colors.black,
//                               width: 2,
//                             )
//                         ),
//                       ),
//                       validator: (value){
//                         if(value!.isEmpty){
//                           return "Enter email";
//                         }
//                         else return null;
//                       },
//                     ),
//                     SizedBox(height: 20,),
//
//                     TextFormField(
//                       obscureText: true,
//                       controller: passwordController,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.password),
//                         hintText: "New Password",
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                               color: Colors.blue,
//                               width: 2,
//                             )
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                               color: Colors.black,
//                               width: 2,
//                             )
//                         ),
//                       ),
//                       validator: (value){
//                         if(value!.isEmpty){
//                           return "Enter password";
//                         }
//                         else return null;
//                       },
//                     ),
//                     SizedBox(height: 30,),
//                   ],
//                 )
//             ),
//             RoundButton(title: 'Sign Up' ,
//               loading: loading,
//               onTap: (){
//                 signUp();
//               },
//             ),
//             SizedBox(height: 30,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Already have an account ?  " , style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black
//                 ),),
//                 InkWell(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//                   },
//                   child: Text("Sign In" , style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
