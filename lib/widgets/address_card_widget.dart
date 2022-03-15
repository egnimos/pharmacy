import 'package:flutter/material.dart';
import '../models/address.dart';
import '../Screens/Checkout/add_new_address.dart';

class AddressCardWidget extends StatelessWidget {
  final Address address;
  final bool isEditable;
  final int selectedId;
  final Function(int id) select;
  const AddressCardWidget({
    required this.selectedId,
    this.isEditable = false,
    required this.address,
    required this.select,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 8),
      // width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      alignment: Alignment.center,
      child: ListTile(
        leading: address.type == 'Office'
            ? const Icon(Icons.business_center_rounded)
            : const Icon(Icons.home),
        title: Row(
          children: [
            Text(address.name + " . "),
            if (!isEditable)
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewAddress(
                        addressInfo: address,
                        from: 'payment',
                      ),
                    ),
                  );
                },
                child: const Text(
                  "edit",
                  style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
          ],
        ),
        subtitle: Text(
          address.name +
              ' ' +
              address.city.name +
              ' ' +
              address.state.name +
              ' ' +
              address.country.name,
        ),
        onTap: () {
          select(address.id);
        },
        trailing: isEditable
            ? const Icon(
                Icons.edit,
              )
            : selectedId == address.id
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.circle,
                  ),
      ),
    );
  }
}
