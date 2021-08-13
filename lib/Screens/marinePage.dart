import 'package:emeenuser/Models/items.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_auth/firebase_auth.dart';

class InlandPage extends StatefulWidget {
  @override
  _InlandPageState createState() => _InlandPageState();
}

class _InlandPageState extends State<InlandPage>
    with AutomaticKeepAliveClientMixin<InlandPage> {
  @override
  bool get wantKeepAlive => true;
  double scheight;
  double scwidth;


  @override
  Widget build(BuildContext context) {
    scheight = MediaQuery.of(context).size.height;
    scwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('Products').where(
                  'Productcategory', isEqualTo: 'Inland').get(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? CircularProgressIndicator()
                    : ListView.builder(
                  itemCount: dataSnapshot.data.docs.length,
                  cacheExtent: 9999,
                  itemBuilder: (context, index) {
                    ItemModel model = ItemModel.fromJson(
                        dataSnapshot.data.docs[index].data());
                    return sourceInfo(model, context);
                  },
                );
              },
            ),
          ),
        )
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
    // showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return StreamBuilder<Object>(
    //           stream: FirebaseAuth.instance.authStateChanges(),
    //           builder: (_, snap) {
    //             if (snap.connectionState == ConnectionState.active) {
    //               if (snap.data != null) {
    //                 return Btmsht(model);
    //               }else{
    //                 return Btmsht2(model);
    //               }
    //             }
    //
    //           }
    //       );
    //     });
  }
}

