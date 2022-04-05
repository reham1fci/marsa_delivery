import 'package:flutter/material.dart';
import 'package:marsa_delivery/model/point_sale_client.dart';
import 'package:marsa_delivery/utill/app_color.dart';


class ClientSearchView  extends StatefulWidget {
   // List<Product> productsList  = [] ;
    Function onChanged;
    Function onSearchEnd  ;
    Function onFilter ;
    ClientSearchView({Key? key,required this.onChanged , required this.onSearchEnd ,required this.onFilter}) : super(key: key);

  @override
  State<ClientSearchView> createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends State<ClientSearchView> {

  Icon actionIcon = const  Icon(Icons.search, color: Colors.white,);
  Widget appBarTitle =  const Center(child:Text("", style:  TextStyle(color: Colors.white),));
  final TextEditingController _searchQuery =  TextEditingController();
  bool? _IsSearching ;
  String _searchText = "";
  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _IsSearching = false;


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Container( color: AppColors.colorPrimary, width: double.infinity, child:Row(
        children: <Widget>[
       Expanded(child:  appBarTitle ,),
           IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
               actionIcon =  const Icon(Icons.close, color: Colors.white,);
                appBarTitle =  TextField(
                  controller: _searchQuery,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon:  Icon(Icons.search, color: Colors.white),
                      hintText: "ابحث اسمه او رقمه او التاريخ ...",
                      hintStyle:  TextStyle(color: Colors.grey)
                  ),
                   onChanged: (string ){
                    widget.onChanged(string) ;
                   },
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },
           ),
        /*  IconButton(onPressed:(){
             widget.onFilter();
          }, icon:const Icon(Icons.filter_alt ,color: Colors.white,))*/
        ]
    ));
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
      //widget.onSearchEnd();

    });
  }

  void _handleSearchEnd() {
    setState(() {
   actionIcon = const Icon(Icons.search, color: Colors.white,);
appBarTitle =
   const  Center(child:Text("", style:  TextStyle(color: Colors.white),));
      _IsSearching = false;
      _searchQuery.clear();
       widget.onSearchEnd();
    });
  }}
