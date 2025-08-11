class CurrentCustomerModal {
  String? message;
  String? status;
  Data? data;

  CurrentCustomerModal({this.message, this.status, this.data});

  // Updated fromJson: Handle nullable fields explicitly
  CurrentCustomerModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    // Check if 'data' exists before trying to parse it
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        <String, dynamic>{}; // Use Map<String, dynamic> for clarity
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  List<Roles>? roles; // Made nullable
  String? primaryContact;
  String? creationTime;
  List<String>? referralCodes; // Made nullable
  List<Addresses>? addresses; // Made nullable
  Wallet? wallet;
  bool? register;

  Data({
    this.id,
    this.fullName,
    this.roles,
    this.primaryContact,
    this.creationTime,
    this.referralCodes,
    this.addresses,
    this.wallet,
    this.register,
  });

  // Updated fromJson: Handle all fields as potentially null
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    // Handle roles list: if null, initialize as empty list
    if (json['roles'] != null) {
      roles = []; // Initialize as empty list
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    } else {
      roles = null; // Ensure it's null if not present
    }
    primaryContact = json['primaryContact'];
    creationTime = json['creationTime'];
    // Handle referralCodes list: if null, initialize as empty list
    referralCodes = json['referralCodes']
        ?.cast<String>(); // Use null-aware access for lists
    // Handle addresses list: if null, initialize as empty list
    if (json['addresses'] != null) {
      addresses = []; // Initialize as empty list
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    } else {
      addresses = null; // Ensure it's null if not present
    }
    // Handle wallet object: check if null before parsing
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    register = json['register']; // `bool?` already handles null implicitly
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['primaryContact'] = primaryContact;
    data['creationTime'] = creationTime;
    data['referralCodes'] = referralCodes;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    data['register'] = register;
    return data;
  }
}

class Roles {
  String? name;
  int? id;

  Roles({this.name, this.id});

  // All fields already nullable, parsing handles null implicitly
  Roles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Addresses {
  int? id;
  String? doorNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? postalCode;
  String? state;
  String? otherDetails;
  String? villageId;
  String? villageName;
  bool? isDefaultAddress; // Already nullable

  Addresses({
    this.id,
    this.doorNumber,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.postalCode,
    this.state,
    this.otherDetails,
    this.villageId,
    this.villageName,
    this.isDefaultAddress,
  });

  // Updated fromJson: Use null-aware operators or provide default for non-nullable types if desired
  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doorNumber = json['doorNumber'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    postalCode = json['postalCode'];
    state = json['state'];
    otherDetails = json['otherDetails'];
    villageId = json['villageId'];
    villageName = json['villageName'];
    // If you want isDefaultAddress to default to false if not present, keep `?? false`.
    // If you want it to be truly nullable, remove `?? false`.
    isDefaultAddress = json['isDefaultAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doorNumber'] = doorNumber;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['city'] = city;
    data['postalCode'] = postalCode;
    data['state'] = state;
    data['otherDetails'] = otherDetails;
    data['villageId'] = villageId;
    data['villageName'] = villageName;
    data['isDefaultAddress'] =
        isDefaultAddress; // If it's nullable, no ?? false needed here
    return data;
  }
}

class Wallet {
  int? id;
  double? availableBalance;
  double? scratchCardAmount;
  double? totalAmount;
  int? referedCount;
  String? mobilNumber;

  Wallet({
    this.id,
    this.availableBalance,
    this.scratchCardAmount,
    this.totalAmount,
    this.referedCount,
    this.mobilNumber,
  });

  // Updated fromJson: Use null-aware operators for numbers to handle potential nulls
  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // For doubles and ints, direct assignment handles null, but you can explicitly cast if needed
    // or provide default values if you want non-nullable fields.
    availableBalance = json['availableBalance']
        ?.toDouble(); // Explicit toDouble() is good practice
    scratchCardAmount = json['scratchCardAmount']?.toDouble();
    totalAmount = json['totalAmount']?.toDouble();
    referedCount = json['referedCount'];
    mobilNumber = json['mobilNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['availableBalance'] = availableBalance;
    data['scratchCardAmount'] = scratchCardAmount;
    data['totalAmount'] = totalAmount;
    data['referedCount'] = referedCount;
    data['mobilNumber'] = mobilNumber;
    return data;
  }
}
