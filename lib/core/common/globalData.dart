class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  int? userId;
  int? addressId;

  String? customerName;
  String? villageId;
  String? villageName;
  String? postalCode;
  String? primaryContact;
  int? selectedAddressId;

  bool? isAdmin;
  bool? isAgent;
  bool? isDeliveryBoy;
  bool? eraseData;
  bool? defaultAddressPostalCode;

  double? walletAmount;

  void reset() {
    walletAmount = null;
    customerName = null;
    userId = null;
    addressId = null;
    villageId = null;
    selectedAddressId = null;
    eraseData = null;
    primaryContact = null;
    isAdmin = null;
    isAgent = null;
    isDeliveryBoy = null;
    defaultAddressPostalCode = null;
    villageName = null;
    postalCode = null;
  }
}
