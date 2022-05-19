import 'package:flutter/material.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/customer_details_body.dart';

class CustomerDetails extends StatelessWidget{
  String customerID;
  String disDate ;

  CustomerDetails(this.customerID, this.disDate);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomerDetailsBody(customerID: customerID,disDate: disDate,) ;
  }
}