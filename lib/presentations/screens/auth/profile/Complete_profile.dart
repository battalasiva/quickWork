import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String? mobileNumber;
  const CompleteProfileScreen({super.key, this.mobileNumber});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  // final TextEditingController doorNumberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController sonOfController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController mandalController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController otherDetailsController = TextEditingController();
  final TextEditingController primaryContactController =
      TextEditingController();
  final TextEditingController referrelCodeController = TextEditingController();

  dynamic districtMandalData = [];
  bool hasCalledFunction = false;
  String? villageId, villageName;
  bool _locationPermissionDenied = false;
  @override
  void initState() {
    super.initState();
    primaryContactController.text = widget.mobileNumber ?? '';
    _fetchLocation();
    postalCodeController.addListener(_onPincodeChanged);
  }

  final _formKey = GlobalKey<FormState>();

  void _onPincodeChanged() {
    String pincode = postalCodeController.text.trim();

    if (pincode.length == 6 && !hasCalledFunction) {
      hasCalledFunction = true;
      fetchDistrictMandal(pincode);
    } else if (pincode.length < 6) {
      hasCalledFunction = false;
    }
  }

  fetchDistrictMandal(postalcode) {
    final parsedPincode = int.tryParse(postalcode);
    if (parsedPincode != null) {
      // context
      //     .read<DistrictMandalListCubit>()
      //     .fetchDistrictMandalList(context, parsedPincode);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid postal code'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  updateProfile() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fields not validated'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (villageId == null || villageId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a village'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final data = {
      // "email": emailController.text,
      "fullName":
          "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
      "primaryContact": widget.mobileNumber,
      "referalCode": referrelCodeController.text,
      "addressDTO": {
        // "doorNumber": doorNumberController.text,
        "addressLine1": streetController.text,
        "addressLine2": sonOfController.text,
        "villageId": villageId ?? '',
        "villageName": villageName ?? '',
        "city": mandalController.text,
        // "state": mandalController.text,
        "postalCode": postalCodeController.text,
      },
    };
    print('Update Profile Data: $data');
    // context.read<UpdateUserDetailsCubit>().updateUserDetails(context, data);
  }

  Future<void> _fetchLocation() async {
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   setState(() {
    //     // _fetchedLocation = "Location services are disabled.";
    //   });
    //   return;
    // }

    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     setState(() {
    //       // _fetchedLocation = "Location permissions are denied.";
    //     });
    //     return;
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   setState(() {
    //     // _fetchedLocation = "Location permissions denied.";
    //   });
    //   return;
    // }

    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // await _getAddressFromCoordinates(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(latitude, longitude);
    // Placemark place = placemarks[0];
    // postalCodeController.text = place.postalCode ?? '';
    // fetchDistrictMandal(postalCodeController.text);
  }

  @override
  void dispose() {
    usernameController.dispose();
    // emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    // doorNumberController.dispose();
    streetController.dispose();
    sonOfController.dispose();
    cityController.dispose();
    mandalController.dispose();
    postalCodeController.dispose();
    otherDetailsController.dispose();
    referrelCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Complete Profile', isLeading: false),
      backgroundColor: AppColor.white,
      // body: BlocConsumer<DistrictMandalListCubit, DistrictMandalListState>(
      //   listener: (context, state) {
      //     if (state is DistrictMandalListSuccess) {
      //       districtMandalData = state.list;
      //       if (districtMandalData.isEmpty) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //               content:
      //                   Text('No villages/mandals found for this postal code.'),
      //               backgroundColor: AppColor.red),
      //         );
      //       }
      //     } else if (state is DistrictMandalListError) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //             content: Text(state.message), backgroundColor: Colors.red),
      //       );
      //     }
      //   },
      //   builder: (context, state) {
      //     return SingleChildScrollView(
      //       padding: const EdgeInsets.all(16),
      //       child: Form(
      //         key: _formKey,
      //         child: Column(
      //           children: [
      //             if (state is DistrictMandalListLoading)
      //               const Center(child: AppLoader()),
      //             if (state is! DistrictMandalListLoading) ...[
      //               TextInputWidget(
      //                 label: 'Name',
      //                 suffixIcon:
      //                     Icon(Icons.person_outline, color: AppColor.grey),
      //                 controller: firstNameController,
      //                 hint: 'Enter your name',
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return 'name is required';
      //                   }
      //                   return null;
      //                 },
      //               ),
      //               const SizedBox(height: 12),
      //               TextInputWidget(
      //                 label: 'Sur Name',
      //                 suffixIcon:
      //                     Icon(Icons.person_outline, color: AppColor.grey),
      //                 controller: lastNameController,
      //                 hint: 'Enter your sur name',
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return 'sur name is required';
      //                   }
      //                   return null;
      //                 },
      //               ),
      //               const SizedBox(height: 12),
      //               TextInputWidget(
      //                 label: 'S/O',
      //                 suffixIcon:
      //                     Icon(Icons.person_outline, color: AppColor.grey),
      //                 controller: sonOfController,
      //                 hint: 'Enter S/O',
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return 'S/O is required';
      //                   }
      //                   return null;
      //                 },
      //               ),
      //               // const SizedBox(height: 12),
      //               // TextInputWidget(
      //               //   label: 'Email',
      //               //   suffixIcon:
      //               //       Icon(Icons.email_outlined, color: AppColor.grey),
      //               //   controller: emailController,
      //               //   hint: 'Enter your email',
      //               //   keyboardType: TextInputType.emailAddress,
      //               //   validator: (value) {
      //               //     if (value == null || value.isEmpty) {
      //               //       return 'Email is required';
      //               //     } else if (!RegExp(
      //               //             r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      //               //         .hasMatch(value)) return null;
      //               //   },
      //               // ),
      //               const SizedBox(height: 12),
      //               TextInputWidget(
      //                 label: 'Refferal Code',
      //                 suffixIcon:
      //                     Icon(Icons.redeem_outlined, color: AppColor.grey),
      //                 controller: referrelCodeController,
      //                 hint: 'Enter Refferal Code (Optional)',
      //                 keyboardType: TextInputType.number,
      //                 maxLength: 10,
      //               ),
      //               const SizedBox(height: 12),
      //               TextInputWidget(
      //                 keyboardType: TextInputType.number,
      //                 digitsOnly: true,
      //                 readOnly: true,
      //                 label: 'Primary Contact',
      //                 suffixIcon:
      //                     Icon(Icons.phone_outlined, color: AppColor.grey),
      //                 controller: primaryContactController,
      //                 hint: 'Enter your Primary Contact',
      //               ),
      //               const SizedBox(height: 12),
      //               // Row(
      //               //   children: [
      //               //     Expanded(
      //               //       child: TextInputWidget(
      //               //         label: 'Door No',
      //               //         suffixIcon:
      //               //             Icon(Icons.home_outlined, color: AppColor.grey),
      //               //         controller: doorNumberController,
      //               //         hint: '101',
      //               //         validator: (value) {
      //               //           if (value == null || value.isEmpty) {
      //               //             return 'Door number is required';
      //               //           }
      //               //           return null;
      //               //         },
      //               //       ),
      //               //     ),
      //               //     const SizedBox(width: 12),
      //               //     Expanded(
      //               //       child: TextInputWidget(
      //               //         label: 'Postal Code',
      //               //         suffixIcon: Icon(Icons.location_on_outlined,
      //               //             color: AppColor.grey),
      //               //         controller: postalCodeController,
      //               //         hint: '123456',
      //               //         keyboardType: TextInputType.number,
      //               //         digitsOnly: true,
      //               //         maxLength: 6,
      //               //         validator: (value) {
      //               //           if (value == null || value.isEmpty) {
      //               //             return 'Postal code is required';
      //               //           } else if (value.length != 6) {
      //               //             return 'Postal code must be 6 digits';
      //               //           }
      //               //           return null;
      //               //         },
      //               //       ),
      //               //     ),
      //               //   ],
      //               // ),
      //               TextInputWidget(
      //                 label: 'Postal Code',
      //                 suffixIcon: Icon(Icons.location_on_outlined,
      //                     color: AppColor.grey),
      //                 controller: postalCodeController,
      //                 hint: '123456',
      //                 keyboardType: TextInputType.number,
      //                 digitsOnly: true,
      //                 maxLength: 6,
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return 'Postal code is required';
      //                   } else if (value.length != 6) {
      //                     return 'Postal code must be 6 digits';
      //                   }
      //                   return null;
      //                 },
      //               ),
      //               const SizedBox(height: 12),
      //               CustomDropDownSearchField(
      //                 label: 'Village',
      //                 users: districtMandalData
      //                     .map<Map<String, dynamic>>((village) => {
      //                           "name": village.name,
      //                           "villageId": village.villageId,
      //                           "villageName": village.name,
      //                           "mandalName": village.mandal.name,
      //                         })
      //                     .toList(),
      //                 selectedUser: {
      //                   "name": cityController.text,
      //                   "villageId": villageId,
      //                   "villageName": villageName,
      //                   "mandalName": mandalController.text,
      //                 },
      //                 onUserSelected: (selected) {
      //                   if (selected != null) {
      //                     villageId = selected["villageId"] ?? '';
      //                     villageName = selected["villageName"] ?? '';
      //                     mandalController.text = selected["mandalName"] ?? '';
      //                   }
      //                 },
      //               ),
      //               const SizedBox(height: 12),
      //               TextInputWidget(
      //                 label: 'Mandal',
      //                 suffixIcon: Icon(Icons.location_city_outlined,
      //                     color: AppColor.grey),
      //                 controller: mandalController,
      //                 hint: 'Enter your Mandal',
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return 'Mandal is required';
      //                   }
      //                   return null;
      //                 },
      //               ),
      //               const SizedBox(height: 12),
      //               TextInputWidget(
      //                 label: 'Street Address',
      //                 suffixIcon: Icon(Icons.location_on_outlined,
      //                     color: AppColor.grey),
      //                 controller: streetController,
      //                 hint: 'Enter Street Address',
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return 'Street Address is required';
      //                   }
      //                   return null;
      //                 },
      //               ),
      //               const SizedBox(height: 12),
      //             ]
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),

      /// Bottom Button
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: BlocConsumer<UpdateUserDetailsCubit, UpdateUserDetailsState>(
      //     listener: (context, state) {
      //       if (state is UpdateUserDetailsSuccess) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //             content: Text('Profile updated successfully'),
      //             backgroundColor: Colors.green,
      //           ),
      //         );
      //         // Navigator.popUntil(context, (route) => route.isFirst);
      //         //  Navigator.pop(context, true);
      //         Navigator.of(context).pushAndRemoveUntil(
      //           MaterialPageRoute(builder: (_) => BottomTabNavigator()),
      //           (route) => false,
      //         );
      //       } else if (state is UpdateUserDetailsError) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //               content: Text(state.message), backgroundColor: Colors.red),
      //         );
      //       }
      //     },
      //     builder: (context, state) {
      //       return CustomizedButton(
      //           label: 'Update Profile',
      //           style: txt_15_500.copyWith(color: AppColor.white),
      //           isLoading: state is UpdateUserDetailsLoading,
      //           onPressed:
      //               state is UpdateUserDetailsLoading ? () {} : updateProfile);
      //     },
      //   ),
      // ),
    );
  }
}
