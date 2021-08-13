import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'inlandPage.dart';
import 'marinePage.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 3,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Color(0xff0c395a),
            labelColor: Color(0xff0c395a),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            tabs: <Widget>[new Tab(text: 'Marine'), new Tab(text: 'Inland')],
          ),
          backgroundColor: Colors.white,
          title: Container(
            child: Text(
              'Categories',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xff0c395a), fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            Center(
              child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (_, snap) {
                  if (snap.connectionState == ConnectionState.active) {
                    if (snap.data != null) {
                      return Stack(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Color(0xff0c395a),
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     new MaterialPageRoute(
                                //         builder: (context) => new CartPage()));
                              }),

                        ],
                      );
                    } else {
                      return Stack(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Color(0xff0c395a),
                              ),
                              onPressed: null),
                        ],
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ),
        body: new TabBarView(controller: _tabController, children: <Widget>[
          MarinePage(),
          InlandPage(),
        ]),
      ),
    );
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}

