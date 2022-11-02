import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/category_deals';
  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  HomeServices homeServices = HomeServices();
  List<Product>? productList;

  fetchAllProducts() async {
    var result = await homeServices.fetchCategoryProduct(
        context: context, category: widget.category);
    productList = [...result];
    setState(() {});
    print(productList);
  }

  @override
  void initState() {
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(color: Colors.black),
            )),
      ),
      body: productList == null
          ? const Loader()
          : productList!.isEmpty
              ? const Center(child: Text('No product yet'))
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Keep Shopping for ${widget.category}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      child: GridView.builder(
                          itemCount: productList!.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: ((context, index) {
                            final product = productList![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProductDeals.routeName,
                                    arguments: product);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 130,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(product.images[0]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 5, right: 15),
                                    child: Text(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                    )
                  ],
                ),
    );
  }
}
