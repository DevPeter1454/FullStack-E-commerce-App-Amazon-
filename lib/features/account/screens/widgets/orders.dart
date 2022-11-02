import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    'https://images.unsplash.com/photo-1660584526276-d5ffbab94f98?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8eGpQUjRobGtCR0F8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1660584526276-d5ffbab94f98?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8eGpQUjRobGtCR0F8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1660584526276-d5ffbab94f98?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8eGpQUjRobGtCR0F8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1660584526276-d5ffbab94f98?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8eGpQUjRobGtCR0F8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 15.0),
                child: const Text(
                  'Your Orders',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )),
            Container(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 18,
                      color: GlobalVariables.selectedNavBarColor,
                      fontWeight: FontWeight.w600),
                ))
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return SingleProduct(image: list[index]);
              }),
        )
      ],
    );
  }
}
