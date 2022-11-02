import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();
  String addressToBeUsed = "";
  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;
    if (isForm) {
      if (addressKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text} ${areaController.text} ${cityController.text} - ${pincodeController.text} ';
      } else {
        throw Exception("Please enter a valid address");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error');
    }
    print(addressToBeUsed);
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        label: 'Total Amount',
        amount: widget.totalAmount,
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: addressKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: flatBuildingController,
                        hintText: 'Flat, House No, Building'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: areaController, hintText: 'Area, Street'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: pincodeController, hintText: 'PinCode'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: cityController, hintText: 'Town/City'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              GooglePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                type: GooglePayButtonType.buy,
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                margin: const EdgeInsets.only(top: 15),
                height: 50,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
