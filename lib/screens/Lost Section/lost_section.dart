import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostify/auth/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:lostify/screens/Lost%20Section/new_lost_item.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:lostify/screens/Lost%20Section/users_lost_request.dart';
import 'package:lostify/screens/hidden_drawer_menu.dart';
import '../../utils/utilities.dart';
import '../Found Section/found_section.dart';
import '../Found Section/users_found_items.dart';


class LostSection extends StatefulWidget {
  const LostSection({super.key});

  @override
  State<LostSection> createState() => _LostSectionState();
}

class _LostSectionState extends State<LostSection> {
  DateFormat dateFormat = DateFormat('dd MMM, yyyy  h:mm a');
  int navigationIndex = 0;
  bool sorted = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final searchFilter = TextEditingController();
  final refAll = FirebaseDatabase.instance.ref('Lost Items/All');
  final refSmartphones = FirebaseDatabase.instance.ref('Lost Items/Smartphones');
  final refBooks = FirebaseDatabase.instance.ref('Lost Items/Books');
  final refSmartGadgets = FirebaseDatabase.instance.ref('Lost Items/Smart Gadgets');
  final refStationary = FirebaseDatabase.instance.ref('Lost Items/Stationary');

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  Widget lostIcon = Image.asset(
    'lib/assets/lostIconDrawer.png', // Replace with your image asset path
    width: 24, // Set the width of your icon
    height: 24, // Set the height of your icon
  );

  Widget foundIcon = Image.asset(
    'lib/assets/foundIconDrawer.png', // Replace with your image asset path
    width: 24, // Set the width of your icon
    height: 24, // Set the height of your icon
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: DefaultTabController(
          length: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu),
                      color: Colors.pink[800],
                      onPressed: (){
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                    Text(
                      "Lostify",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _auth.signOut().then((value) {
                            Utils().toastMessage("Logged out successfully");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          });
                        });
                      },
                      icon: Container(
                        padding: EdgeInsets.all(0),
                        width: 33,
                        height: 33,
                        child: CircleAvatar(
                          backgroundColor: Colors.pink[800],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: searchFilter,
                  onChanged: (String value) {
                    setState(() {});
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: "Search",
                    filled: true,
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                  ),
                ),

                TabBar(
                  isScrollable: true,
                  enableFeedback: true,
                  indicator: UnderlineTabIndicator(
                      borderRadius: BorderRadius.circular(20) ,
                      borderSide: BorderSide(width: 2.5, color: Colors.pink.shade800)
                  ),
                  indicatorColor: Colors.pink.shade800,
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                  unselectedLabelColor: Colors.grey.shade800,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                  tabs: [
                    Tab(
                      child: Text("All"),
                    ),
                    Tab(
                      child: Text("Smartphones"),
                    ),
                    Tab(
                      child: Text("Books"),
                    ),
                    Tab(
                      child: Text("Smart Gadgets"),
                    ),
                    Tab(
                      child: Text("Stationary"),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TabBarView(children: [

                    // All category
                    buildLiquidPullToRefresh(refAll),

                    // Smartphones Category
                    buildLiquidPullToRefresh(refSmartphones),

                    // Books Category
                    buildLiquidPullToRefresh(refBooks),

                    // Smart Gadgets
                    buildLiquidPullToRefresh(refSmartGadgets),

                    // Stationary
                    buildLiquidPullToRefresh(refStationary),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),

      drawer: Drawer(
        child: Container(
            color: Colors.pink.shade800,
            child: ListView(
              children: [
                DrawerHeader(child: Center(
                  child: Text("LOSTIFY" , style: GoogleFonts.roboto(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 4,
                  ),),
                )),

                ListTile(
                  leading: lostIcon,
                  title: Text("Lost Section" , style: GoogleFonts.lato(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),)
                  ,
                  trailing: Icon(Icons.navigate_next , color: Colors.white,),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LostSection()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person , color: Colors.white,),
                  title: Text("My Requests" , style: GoogleFonts.lato(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),)
                  ,
                  trailing: Icon(Icons.navigate_next , color: Colors.white,),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyLostRequests()));
                  },
                ),
                ListTile(
                  leading: foundIcon,
                  title: Text("Found Section" , style: GoogleFonts.lato(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),)
                  ,
                  trailing: Icon(Icons.navigate_next , color: Colors.white,),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FoundSection()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person , color: Colors.white,),
                  title: Text("Found by me" , style: GoogleFonts.lato(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),)
                  ,
                  trailing: Icon(Icons.navigate_next , color: Colors.white,),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyFoundItems()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout , color: Colors.white,),
                  title: Text("Logout" , style: GoogleFonts.lato(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),)
                  ,
                  // trailing: Icon(Icons.navigate_next , color: Colors.white,),
                  onTap: (){
                    _auth.signOut().then((value) {
                      Utils().toastMessage("Logged out successfully");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                ),
              ],
            )
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewLostItem()));

          // if (result != null) {
          //   setState(() {
          //
          //   });
          },
        backgroundColor: Colors.pink[800],
        child: Icon(Icons.add),
      ),

    );

  }

  LiquidPullToRefresh buildLiquidPullToRefresh(DatabaseReference ref) {
    return LiquidPullToRefresh(
                    onRefresh: _handleRefresh,
                    color: Colors.pink.shade800,
                    animSpeedFactor: 2,
                    showChildOpacityTransition: false,
                    child: Expanded(
                      child: FirebaseAnimatedList(
                          query: ref,
                          itemBuilder: (context, snapshot, animation, index) {
                            int time = int.parse(snapshot.child('id').value.toString());
                            var dt = DateTime.fromMillisecondsSinceEpoch(time);
                            var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);

                            String itemName =
                            snapshot.child('itemName').value.toString();
                            String userName =
                            snapshot.child('userName').value.toString();
                            String description =
                            snapshot.child('description').value.toString();

                            if (searchFilter.text.isEmpty) {
                              return Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Colors.pink.shade800,
                                      width: 1.5,
                                    )),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      itemName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          userName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "Time added: ${date}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade700,
                                              fontStyle: FontStyle.italic),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),

                                    trailing: IconButton(
                                      icon: Icon(Icons.navigate_next),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              );
                            }
                            else if (itemName.toLowerCase().contains(searchFilter
                                .text
                                .toString()
                                .toLowerCase()
                                .toString()) ||
                                description.toLowerCase().contains(searchFilter.text
                                    .toString()
                                    .toLowerCase()
                                    .toString())) {
                              return Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Colors.pink.shade800,
                                      width: 1.5,
                                    )),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      itemName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          userName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "Time added: ${date}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade700,
                                              fontStyle: FontStyle.italic),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.navigate_next),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              );
                            }
                            else {
                              return Container();
                            }
                          }),
                    ),
                  );
  }
}
