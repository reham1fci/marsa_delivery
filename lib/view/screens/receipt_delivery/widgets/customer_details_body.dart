
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';import 'package:marsa_delivery/ApiConnection/Api.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/model/Shipment.dart';
import 'package:marsa_delivery/model/point_sale_client.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_constant.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/customer_card.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/image_view.dart';
import 'package:marsa_delivery/view/screens/receipt_delivery/widgets/shipment_item.dart';
class CustomerDetailsBody extends StatefulWidget{
  String customerID;
  String disDate ;

  CustomerDetailsBody({  required this.customerID,  required this.disDate});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<CustomerDetailsBody> {
  String? _customerID;
  String? _disDate ;
   Api api  = Api()  ;
  PointSaleClient? client  ;
   List<Shipment>shipmentList  = []  ;
  XFile? _image;
  bool addImageBtn = true ;
  // List<String> ordImg = new List();
  String ordImg  =  "";
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _customerID  = widget.customerID  ; 
    _disDate  = widget.disDate  ;
    Map<String, dynamic> map  = {} ;
    map["customer_id"]= _customerID  ;
    map["dis_date"] =  _disDate ;
    api.request(url: Constants.SHOW_CUSTOM_DETAILS, map: map, onSuccess: onSuccessReq, onError: onError) ;
  }
    onSuccessReq(var jsonObj){
      var jsonStr = json.decode(jsonObj);
      List<dynamic> list = jsonStr["list"];
      for(int i  = 0 ; i<list.length ; i++){
        print(list[i]) ;
        Shipment ship = Shipment.fromJsonCustomer(list[i]) ;
        setState(() {
          shipmentList.add(ship) ;
        });
      }
      setState(() {
        client  = PointSaleClient.fromJsonDetails(jsonStr, _customerID!) ;

      });

print(jsonStr) ;
    }
     onError(String err){
       print("here err");

       print(err);
     }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar: AppBar(
            iconTheme:  const IconThemeData(color: AppColors.appBarIcon),
            centerTitle: true,
            systemOverlayStyle:const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: AppColors.statusAppBar,),
            backgroundColor: AppColors.appBar,title:Text( getTranslated("details", context)??"",style: const TextStyle(color: AppColors.logRed),) ) ,

        body:   client != null  ?  Container( height :double.infinity,child:   Column(children: [

       CustomerCard(client!),
          Divider(),
        client!.imageLocation!.isEmpty?


       TextButton(child: Text(getTranslated("add_image", context)??"" , style:
          TextStyle(color: Colors.white),),onPressed:getImage,style:
          ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.logRed,))):
        GestureDetector(
          child:  Image.network(client!.imageLocation!,height: 150,),onTap: (){
          Navigator.push( context,
              MaterialPageRoute(builder: (context) => ImageView(client!.imageLocation!))) ;
        },) ,
           _image!= null? Image.file(File(_image!.path),height: 150,):SizedBox(),
           _image!= null?   TextButton(child: Text(getTranslated("upload", context)??"" , style:
           TextStyle(color: Colors.white),),onPressed:onUploadClick,style:
           ButtonStyle(backgroundColor:MaterialStateProperty.all(AppColors.logRed,))):SizedBox(),
          Text(getTranslated("shipment", context)??"",style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.logRed),),
          Expanded(child: ListView.builder(
            itemBuilder: (context  , index ){
         return ShipmentItem(onGet: (){}, obj: shipmentList[index], onRefresh: (){}, enableBtn: false,);
            } ,itemCount:  shipmentList.length , ))])
      ): Center (child:CircularProgressIndicator(color: AppColors.logRed,)) ,);
  }
  Future getImage() async {
    var image;
    final ImagePicker _picker = ImagePicker();
    String type="camera";
    if (type == "camera") {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    final path = image.path;

    List<int> imageBytes = await File(path).readAsBytes();

    setState(()  {
      _image = image;

      // print(imageBytes);
      String base64Image = base64Encode(imageBytes);
      ordImg = base64Image ;
      addImageBtn  = false ;
      print("image");
      List  imName  = _image.toString().split("/") ;
      String m = imName[imName.length-1] ;
      print(m) ;
        //api.sendImage(parentID: clientLocalData.parentId , clientId: clientLocalData.clientId , imagePath: _image.toString() ,requestID: 0 , onResponse: (msg){
      // print(msg);
      //} );
      print(_image);
      //;imagesList.add(Image.file(_image));*/
    });

  }
  onUploadClick(){
    Map<String, dynamic> map  = {} ;
    map["customer_id"]= _customerID  ;
    map["location_image"] =  ordImg ;
    api.request(url: Constants.ADDCUSTOMERIMAGE, map: map, onSuccess: onSuccessAddImage, onError: onError);

  }
onSuccessAddImage(var jsonObj){
     print("here success");
     print(jsonObj);

     
     var jsonStr = json.decode(jsonObj);
print(jsonStr);
}

}