import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String email;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'password': password});
    result.addAll({'email': email});
    result.addAll({'address': address});
    result.addAll({'type': type});
    result.addAll({'token': token});
    result.addAll({"cart": cart});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        password: map['password'] ?? '',
        email: map['email'] ?? '',
        address: map['address'] ?? '',
        type: map['type'] ?? '',
        token: map['token'] ?? '',
        cart: List<Map<String, dynamic>>.from(
          map["cart"]?.map(
            (x) => Map<String, dynamic>.from(x),
          ),
        ));
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
