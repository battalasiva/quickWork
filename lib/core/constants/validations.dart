String? validateProfileData({
  required String username,
  required String email,
  required String fullName,
  required String doorNumber,
  required String addressLine1,
  required String addressLine2,
  required String city,
  required String state,
  required String postalCode,
  required String otherDetails,
}) {
  if (username.isEmpty) return 'Username is required';
  if (email.isEmpty) return 'Email is required';
  if (fullName.isEmpty) return 'Full name is required';
  if (doorNumber.isEmpty) return 'Door number is required';
  if (addressLine1.isEmpty) return 'Address Line 1 is required';
  if (addressLine2.isEmpty) return 'Address Line 2 is required';
  if (city.isEmpty) return 'City is required';
  if (state.isEmpty) return 'Mandal (State) is required';
  if (postalCode.isEmpty) return 'Postal code is required';
  if (otherDetails.isEmpty) return 'Other details are required';
  return null; 
}
