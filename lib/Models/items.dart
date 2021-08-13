
class ItemModel {
  String Producttitle;
  String Productprice;
  String Producticon;
  String Productcategory;
  String Productavailable;
  String ProductID;
  String Discountprice;
  String Productdescription;

  String Productquantity;
  String Discountnote;
  String Discount;

  ItemModel({
    this.Producttitle,
    this.Productquantity,
    this.Productdescription,
    this.Productprice,
    this.Producticon,
    this.Productcategory,
    this.Productavailable,
    this.ProductID,
    this.Discountprice,
    this.Discountnote,
    this.Discount,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    Producttitle = json['Producttitle'];
    Productprice = json['Productprice'];
    Productdescription = json['Productdescription'];
    Productquantity=json['Productquantity'];
    Producticon = json['Producticon'];
    Productcategory = json['Productcategory'];
    Productavailable = json['Productavailable'];
    ProductID = json['ProductID'];
    Discountprice = json['Discountprice'];
    Discountnote = json['Discountnote'];
    Discount = json['Discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Producttitle'] = this.Producttitle;
    data['Productprice'] = this.Productprice;
    data['Producticon'] = this.Producticon;
    data['Productquantity'] = this.Productquantity;
    data['Productdescription'] = this.Productdescription;
    data['Discountprice'] = this.Discountprice;
    data['Discountnote'] = this.Discountnote;
    data['Discount'] = this.Discount;
    data['Productcategory'] = this.Productcategory;
    data['Productavailable'] = this.Productavailable;
    data['ProductID'] = this.ProductID;
    return data;
  }
}
