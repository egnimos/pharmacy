
import 'package:flutter/material.dart';
import 'package:pharmacy/screens/MyCart/my_cart.dart';
import 'package:pharmacy/screens/notifications.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../services/address_service.dart';
import '../theme/color_theme.dart';
import '../widgets/address_card_widget.dart';
import 'Checkout/add_new_address.dart';

class MyAddresses extends StatefulWidget {
  const MyAddresses({Key? key}) : super(key: key);

  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  bool isLoading = false;
  bool _isInit = true;
  List addresses = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      Provider.of<AddressService>(context, listen: false)
          .getAddressList()
          .then((value) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _pullRefresh() async {
    Provider.of<AddressService>(context, listen: false).getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        centerTitle: true,
        title: const Text(
          'My Addresses',
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyCart(),
                ),
              );
            },
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  'assets/icons/Group 3@1X.png',
                  height: 20,
                  color: AppColor.whiteColor,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CARTCOUNT == 0
                      ? const SizedBox.shrink()
                      : Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          child: Text(
                            CARTCOUNT.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Notifications(),
                ),
              );
            },
            icon: Image.asset(
              'assets/icons/Path 4617@1X.png',
              height: 20,
            ),
          ),
        ],
        // automaticallyImplyLeading: false,
      ),
      bottomSheet: Container(
        height: 70,
        padding: const EdgeInsets.only(left: 25, right: 25),
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(-4, -4),
              )
            ]),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewAddress(
                  from: 'addresses',
                ),
              ),
            );
            if (result) {
              _pullRefresh();
            }
          },
          child: Container(
            height: 47,
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
              color: AppColor.appTheme,
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Add New',
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : addresses.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text('No Data'),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Consumer<AddressService>(
                        builder: (ctx, anas, child) => anas.addresses.isEmpty
                            ? const SizedBox.shrink()
                            : Column(
                                children: anas.addresses
                                    .map(
                                      (addr) => AddressCardWidget(
                                        selectedId: 0,
                                        address: addr,
                                        select: (id) {},
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                    ),
                  ),
      ),
    );
  }
}