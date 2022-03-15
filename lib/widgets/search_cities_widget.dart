import 'package:flutter/material.dart';
import 'package:pharmacy/services/address_service.dart';
import 'package:provider/provider.dart';

import '../models/address.dart' as address;

class SearchCitiesWidget extends StatefulWidget {
  final int stateId;
  final void Function(address.City value) selectedCityInfo;
  const SearchCitiesWidget({
    required this.stateId,
    required this.selectedCityInfo,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchCitiesWidget> createState() => _SearchCitiesWidgetState();
}

class _SearchCitiesWidgetState extends State<SearchCitiesWidget> {
  TextEditingController controller = TextEditingController();
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      Provider.of<AddressService>(context, listen: false)
          .getCityList(widget.stateId)
          .then((value) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget cities(List<address.City> cities) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cities.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          contentPadding: const EdgeInsets.only(top: 3),
          onTap: () {
            widget.selectedCityInfo(cities[index]);
            Provider.of<AddressService>(context, listen: false)
                .clearSearchResult();
            Navigator.pop(context);
          },
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cities[index].name,
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text('States List'),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: double.maxFinite,
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cities List',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    //enter the input to search the states
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          top: 2,
                          bottom: 2,
                        ),
                        hintText: 'Search',
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: Colors.grey.shade300, width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: Colors.grey.shade300, width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: Colors.grey.shade300, width: 1.2),
                        ),
                        fillColor: Colors.grey[300],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (val) {
                        Provider.of<AddressService>(context,
                                listen: false)
                            .getSearchListBasedOnInput(val, type: AddressType.city);
                      },
                    ),
                    //show the list of cities
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Consumer<AddressService>(
                          builder: (context, anas, child) {
                        //if search result is empty then return the list of states
                        if (anas.searchResults.isEmpty) {
                          return cities(anas.cities);
                        }
                        return cities(List<address.City>.from(anas.searchResults));
                      }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
