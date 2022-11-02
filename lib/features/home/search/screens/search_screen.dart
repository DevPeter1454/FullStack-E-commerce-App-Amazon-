import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/search/services/search_services.dart';
import 'package:amazon_clone/features/home/search/widget/searched_product.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screens/screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? productsList;
  SearchServices searchServices = SearchServices();

  void fetchSearchProducts() async {
    productsList = await searchServices.fetchSearchedProduct(
        context: context, search: widget.searchQuery);
    if (productsList != null) {
      print(productsList);
    }
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            hintText: 'Search Amazon.in',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1),
                            ),
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ),
        body: productsList == null
            ? const Loader()
            : Column(
                children: [
                  const AddressBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productsList!.length,
                      itemBuilder: (context, index) {
                        final product = productsList![index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDeals.routeName,
                                  arguments: product);
                            },
                            child: SearchedProduct(product: product));
                      },
                    ),
                  )
                ],
              ));
  }
}
