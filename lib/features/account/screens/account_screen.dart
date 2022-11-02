import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/widgets/appbar.dart';
import 'package:amazon_clone/features/account/screens/widgets/orders.dart';
import 'package:amazon_clone/features/account/screens/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( 

        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topRight,
                child:Image.asset('assets/images/amazon_in.png', height: 45, width: 120, ) ,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children:const  [
                    Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.notifications_outlined),),
                    Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.search),),
                  ],)),
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 20),
          Orders(),

        ],)
    );
  }
}
