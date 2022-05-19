
import 'package:flutter/material.dart';
import 'package:marsa_delivery/localization/language_constrants.dart';
import 'package:marsa_delivery/utill/app_color.dart';
import 'package:marsa_delivery/utill/app_images.dart';
import 'package:marsa_delivery/view/screens/main_screen/main_screen.dart';
import 'package:marsa_delivery/view/screens/main_screen/salary_view.dart';
import 'package:marsa_delivery/view/screens/main_screen/user_profile.dart';
import 'package:marsa_delivery/view/screens/main_screen/violation_view.dart';
import 'package:marsa_delivery/view/screens/main_screen/wallet_view.dart';
class AppBottomNavBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<AppBottomNavBar> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return  BottomNavigationBar(
  items: [
    BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(Images.home),
        size: 30,
      ),
      label: getTranslated("home", context),
    ),
    BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(Images.wallet),
        size: 30,
      ),
      label: getTranslated("wallet", context),
    ),
    BottomNavigationBarItem(
      icon:  ImageIcon(
        AssetImage(Images.infraction),
        size: 30,
      ),
      label: getTranslated("violation", context),
    ),
    BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(Images.salary),
        size: 30,
      ),
      label: getTranslated("salary", context),
    ),

    BottomNavigationBarItem(
      icon:  ImageIcon(
        AssetImage(Images.profile),
        size: 30,
      ),
      label: getTranslated("profile", context),
    ),
  ],
  showUnselectedLabels: true,
  showSelectedLabels: true,
  currentIndex: _selectedIndex,
  unselectedItemColor: Colors.grey,
  selectedItemColor: AppColors.logRed,
  onTap: _onTap,
);}


    void _onTap(int index)
    {
      _selectedIndex = index;
      setState(() {
switch(index){
  case 0:
    Navigator.push(context, MaterialPageRoute(builder: (context) => Main()),);
    break;
  case 1:
    Navigator.push(context, MaterialPageRoute(builder: (context) => WalletView()),);
    break;
  case 2:
    Navigator.push(context, MaterialPageRoute(builder: (context) => ViolationView()),);
    break;
  case 3:
    Navigator.push(context, MaterialPageRoute(builder: (context) => SalaryView()),);
    break;
  case 4:
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()),);
    break;
}
      });
    }



}