class Address {
  final int id;
  final String name;
  final String phone;
  final String pincode;
  final String email;
  final String address;
  final Country country;
  final State state;
  final City city;
  final int defAddress;
  final String type;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.pincode,
    required this.email,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.defAddress,
    required this.type,
  });

  //  {address: [{id: 10, name: Niteesh, email: yotox10695@xindax.com, address: Ranusagar, Sonbhadar, type: Home, phone: 7298379212, pin_code: 123456,
  //  country: {id: 101, name: India}, state: {id: 38, name: Uttar Pradesh}, city: {id: 5212, name: Varanasi Cantonment}

  factory Address.fromJson(Map<String, dynamic> data) => Address(
        id: data["id"],
        name: data["name"],
        phone: data["phone"].toString(),
        pincode: data["pin_code"].toString(),
        email: data["email"],
        address: data["address"],
        country: Country.fromJson(data["country"]),
        state: State.fromJson(data["state"]),
        city: City.fromJson(data["city"]),
        defAddress: data["defAddress"],
        type: data["type"],
      );
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'pincode': pincode,
        'email': email,
        'address': address,
        'country_id': country.id.toString(),
        'state_id': state.id.toString(),
        'city_id': city.id.toString(),
        'defaddress': defAddress.toString(),
        'type': type,
      };
}

class Country {
  final int id;
  final String name;

  Country({
    required this.id,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }
}

class State {
  final int id;
  final String name;

  State({
    required this.id,
    required this.name,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'],
      name: json['name'],
    );
  }
}

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}
