import 'package:flutter/material.dart';
import 'package:kontribute/utils/AppColors.dart';
import 'package:kontribute/utils/app.dart';
import 'package:kontribute/utils/screen.dart';

class WalletScreen extends StatefulWidget{
  @override
  WalletScreenState createState() => WalletScreenState();
  
}

class WalletScreenState extends State<WalletScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *5),
              child:
              Row(
                children: [
                  titlebarapp(context, "Wallet"),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}