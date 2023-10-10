import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lostify/utils/utilities.dart';

class NewLostItem extends StatefulWidget {
  const NewLostItem({super.key});

  @override
  State<NewLostItem> createState() => _NewLostItemState();
}

class _NewLostItemState extends State<NewLostItem> {
  TextEditingController _itemController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String? categoryOfItem = "Smartphones";
  final databaseRefLostItems = FirebaseDatabase.instance.ref('Lost Items');
  final databaseRefCategory = FirebaseDatabase.instance.ref('Lost Items');

  String userId = "";

  FirebaseAuth auth = FirebaseAuth.instance;
  _NewLostItemState(){
    User? user = auth.currentUser;
    if(user != null){
      userId = user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_outlined),
                    color: Colors.pink[800],),

                    Text("Add Lost Item" , style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    )),

                    // SizedBox(width: MediaQuery.sizeOf(context).width*.24,),
                    SizedBox(width: 40,)
                  ],
                ),
                SizedBox(height: 10,),
                ItemsTextField(_itemController , "Item"),

                SizedBox(height: 10,),
                ItemsTextField(_nameController , "Name"),

                SizedBox(height: 10,),
                ItemsTextField(_descriptionController , "Description"),

                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text("Returned" , style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),),
                    ),

                    LiteRollingSwitch(
                      colorOn: Colors.pink.shade800,
                      colorOff: Color(0xFFF4F4F4),
                      textSize: 15,
                      textOn: "Yes",
                      textOff: "No",
                      textOnColor: Colors.white,
                      onChanged: (bool state){
                        // if (state) {
                        //
                        // } else {
                        //
                        // }
                      },
                      onTap: (){

                      },
                      onSwipe: (){},
                      onDoubleTap: (){},
                      animationDuration: Duration(milliseconds: 600),
                    )
                  ],
                ),

                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select a category: " , style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),),
                    
                    DropdownButton<String>(
                        value: categoryOfItem,
                        onChanged: (String? newValue){
                          setState(() {
                            categoryOfItem = newValue;
                          });
                        },
                        items: [
                          DropdownMenuItem<String>(
                            value: "Smartphones",
                            child: Text("Smartphones" , style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          DropdownMenuItem<String>(
                            value: "Books",
                            child: Text("Books" , style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),

                          ),
                          DropdownMenuItem<String>(
                            value: "Smart Gadgets",
                            child: Text("Smart Gadgets" , style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          DropdownMenuItem<String>(
                            value: "Stationary",
                            child: Text("Stationary" , style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_itemController.text.isEmpty || _nameController.text.isEmpty || _descriptionController.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Please fill the required fields",
                toastLength: Toast.LENGTH_SHORT,
            );
          }
          else{
            String id = DateTime.now().millisecondsSinceEpoch.toString();
            databaseRefLostItems.child('All').child(id).set({
              'userId' : userId,
              'id' : id,
              'itemName' : _itemController.text.toString(),
              'userName' : _nameController.text.toString(),
              'description' : _descriptionController.text.toString()
            }).then((value){
              Navigator.pop(context , [_itemController.text , _nameController.text  , _descriptionController.text ]);
            }).onError((error, stackTrace){
             print(error.toString());
            });

            databaseRefCategory.child(categoryOfItem!).child(id).set({
              'userId' : userId,
              'id' : id,
              'itemName' : _itemController.text.toString(),
              'userName' : _nameController.text.toString(),
              'description' : _descriptionController.text.toString()
            }).then((value){
              Utils().toastMessage("Added to ${categoryOfItem}");
            }).onError((error, stackTrace){
              print(error.toString());
            });

          }
        },
        backgroundColor: Colors.pink[800],
        child: Icon(Icons.save),
      ),
    );
  }

  Widget ItemsTextField(TextEditingController controller , String labelName){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(labelName , style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.black,
          )),
        ),
        SizedBox(height: 2,),
        TextField(
          maxLines: labelName == "Description" ? 4 : null,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF4F4F4),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.pink.shade800,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}