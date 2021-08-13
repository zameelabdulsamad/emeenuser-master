import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emeenuser/Models/items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'orderScreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   double scheight;
   double scwidth;
  @override
  Widget build(BuildContext context) {
    scheight = MediaQuery.of(context).size.height;
    scwidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        backgroundColor: Colors.white,
        title: Container(
          child: Center(
            child: AspectRatio(
              aspectRatio: 24 / 1,
              child: Image(image: AssetImage("images/emeen.png")),
            ),
          ),
        ),
        actions: [

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
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new OrderScreen()));
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
      body: SafeArea(
           child: SingleChildScrollView(
           child: Container(
             padding: const EdgeInsets.all(16.0),
             width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('Carousel').snapshots(),
                        builder: (context , snapshot){
                          return Container(
                            height: screenHeight * 0.45,
                            child:  new  Carousel(
                              borderRadius: true,
                              radius: Radius.circular(15),
                              boxFit: BoxFit.cover,
                              images: [

                                Image.network(snapshot.data.docs[0]['CImage']),
                                Image.network(snapshot.data.docs[1]['CImage']),
                                Image.network(snapshot.data.docs[2]['CImage']),
                              ],
                              autoplay: true,
                              animationCurve: Curves.fastOutSlowIn,
                              showIndicator: false,
                              autoplayDuration: Duration(milliseconds: 5000),
                              animationDuration: Duration(milliseconds: 1000),
                            ),
                          ) ;
                        },
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                // Navigator.push(
                                //     context,
                                //     new MaterialPageRoute(
                                //         builder: (context) => new InlandPage()));
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Image.asset('images/inland.png'),
                                        iconSize: 55,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text('Inland',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff0c395a))),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                // Navigator.push(
                                //     context,
                                //     new MaterialPageRoute(
                                //         builder: (context) => new MarinePage()));
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Image.asset('images/marine.png'),
                                        iconSize: 55,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          'Marine',
                                          style: TextStyle(
                                              fontSize: 16, color: Color(0xff0c395a)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FutureBuilder<QuerySnapshot>(
                            future:  FirebaseFirestore.instance.collection('Products').where(
                                'Productavailable', isEqualTo: 'true').get(),
                            builder: (context, dataSnapshot) {
                              return !dataSnapshot.hasData
                                  ? CircularProgressIndicator()
                                  : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: dataSnapshot.data.docs.length,
                                cacheExtent: 9999,
                                itemBuilder: (context, index) {
                                  ItemModel model = ItemModel.fromJson(
                                      dataSnapshot.data.docs[index].data());
                                  return sourceInfo(model, context);
                                },
                              );
                            },
                          )
                        ],
                      ),

                    ],
                  ),



           ),
           ),

      ),
    );
  }

   Widget sourceInfo(ItemModel model, BuildContext context,
       {Color background, removeCartFunction})
   {
     return GestureDetector(
       onTap: () => onCardPressed(model),
       child: Card(
         elevation: 1.0,
         margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
         child: Container(
             decoration: BoxDecoration(color: Colors.white),
             child:  Row(
               children: [
                 Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Opacity(
                     opacity:(model.Productavailable=="true"?1:0.5

                     ),
                     child: Image.network(
                       model.Producticon,
                       fit: BoxFit.contain,
                       width: scwidth*0.2,
                       height: scheight*0.2,
                     ),
                   ),
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [

                     Padding(
                       padding: EdgeInsets.only(left:8.0),
                       child: Text(
                         model.Producttitle,
                         style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.w500),
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(left:8.0),
                       child: Text(
                         model.Productdescription,
                         style: TextStyle(color: Colors.grey[700],fontSize: 12.0),
                       ),
                     ),
                     Visibility(

                       visible:(model.Productavailable=="true"?true:false

                       ),


                       child: Padding(
                         padding: EdgeInsets.only(left: 8.0,top: 28.0),
                         child: Text((() {
                           if(model.Productquantity=='0.25'){
                             return "250g";}
                           else if(model.Productquantity=='0.50'){
                             return "500g";}
                           else if(model.Productquantity=='0.75'){
                             return "750g";}
                           else if(model.Productquantity=='1.00'){
                             return "1Kg";}

                         })(),style: TextStyle(
                             color: Colors.grey,
                             fontSize: 14,
                             fontWeight: FontWeight.w400),),
                       ),
                     ),

                     Visibility(

                       visible:(model.Productavailable=="true"?true:false

                       ),

                       child: Padding(
                         padding: EdgeInsets.only(left: 8.0,bottom: 12.0,top: 4.0),
                         child: Row(
                           children: [
                             Visibility(

                               visible:(model.Discount=="true"?true:false

                               ),
                               child: Padding(
                                 padding: EdgeInsets.only(right: 8.0),
                                 child: Text(
                                   model.Discountprice,
                                   style: TextStyle(color: Colors.grey[850],fontSize: 18.0, fontWeight: FontWeight.bold),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(right: 28.0),
                               child: Text(
                                 model.Productprice,


                                 style:(model.Discount=="false"?TextStyle(color: Colors.grey[850],fontSize: 18.0, fontWeight: FontWeight.bold):TextStyle(color: Colors.grey[850],fontSize: 14.0, decoration: TextDecoration
                                     .lineThrough )

                                 ),
                               ),
                             ),
                             Visibility(
                               visible:(model.Discount=="true"?true:false

                               ),


                               child: Text(
                                 model.Discountnote,
                                 style: TextStyle(color: Color(0xff8cc63e),fontSize: 18.0, fontWeight: FontWeight.bold),
                               ),
                             ),

                           ],
                         ),
                       ),
                     ),
                     Visibility(

                       visible:(model.Productavailable=="true"?false:true

                       ),

                       child: Padding(
                         padding: EdgeInsets.only(top: 20.0),
                         child: Card(
                           elevation: 1.0,
                           child: Container(

                             decoration: BoxDecoration(

                               color: Colors.grey[100],

                             ),
                             child: Padding(
                               padding: EdgeInsets.all(6.0),
                               child: Text(
                                 'Currently unavalilable',
                                 style: TextStyle(color:Colors.red,),
                               ),
                             ),
                           ),
                         ),
                       ),
                     )



                   ],
                 ),

               ],
             )
         ),
       ),
     );



   }
   void onCardPressed(ItemModel model) {
     showModalBottomSheet(
         context: context,
         builder: (context) {
           return StreamBuilder<Object>(
               stream: FirebaseAuth.instance.authStateChanges(),
               builder: (_, snap) {
                 if (snap.connectionState == ConnectionState.active) {
                   if (snap.data != null) {
                     return null;
                   }else{
                     return null;
                   }
                 }

               }
           );
         });

   }

}
