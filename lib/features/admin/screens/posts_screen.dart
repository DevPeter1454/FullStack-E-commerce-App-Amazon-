import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/account/screens/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  void naviagteToAddProductScreen() async {
    var data =
        await Navigator.of(context).pushNamed(AddProductScreen.routeName);
    if (data == null) {
      fetchProducts();
      setState(() {
        
      });
    }
  }

  List<Product>? product;

  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    product = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product theProduct, int index) {
    adminServices.deleteProduct(
        context: context,
        product: theProduct,
        onSuccess: () {
          product!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: product!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = product![index];
                  return Column(children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(image: productData.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                        IconButton(
                            onPressed: () {
                              deleteProduct(productData, index);
                            },
                            icon: Icon(Icons.delete_outline))
                      ],
                    )
                  ]);
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: naviagteToAddProductScreen,
              tooltip: 'Add a new product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
