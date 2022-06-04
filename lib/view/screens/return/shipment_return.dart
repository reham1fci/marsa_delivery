import 'package:flutter/material.dart';
import 'package:marsa_delivery/view/screens/return/widgets/return_ship_body.dart';

class ShipmentReturn extends StatelessWidget{
 String?driverID ;


 ShipmentReturn(this.driverID);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ReturnShipmentBody(driverID!);
  }
}