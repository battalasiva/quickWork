const baseUrl = 'https://meatspot.co.in/api/quickwork/';

//Auth
const triggerOtp = 'auth/userotp/trigger?triggerOtp=false';
const signinUrl = 'auth/signin';
const currentCustomer = 'user/userDetails';
const onboarduser = 'customer/user/onboard/user';
String assignRoleUrl(int userId, String roleName) =>
    'user/$userId/role/$roleName';

//work types
const createGetworkTypeUrl = 'api/work-types';
String workTypeById(int userId) => 'api/work-types/$userId';

//Technitians
const createTechnitiansUrl = 'api/technicians/register';
const getTechnitiansUrl = 'api/technicians';
String deleteTechnitian(int id) => 'api/technicians/$id';
String approveTechnicianUrl(int id) => 'api/technicians/$id/approve';

//work requests
const workRequestUrl = 'work-requests';
// //orders & Delivery
// const placeOrderurl = 'customer/api/orders/placeOrder';
// const productsList = 'api/meato/api/products';
// String cancelOrderEndpoint(int orderId) =>
//     'api/meato/api/orders/$orderId/cancel';
// const userOrdersList = 'customer/api/orders/list';
// String orderDetailsEndpoint(String orderId) => 'customer/api/orders/$orderId';
// const bulkOrdersListurl = 'customer/api/orders/assign/bulk';
// const agentOrdersListUrl = 'customer/api/orders/agent/in-progress';
// const deliveryBoyOrdersListUrl = 'customer/api/agents/withDeliveryMan';
// const agentPickAtStoreOrdersUrl = 'customer/api/orders/orders/pick-at-store';
// const updateAgentOrderStatusEndpoint = 'customer/api/orders/updateInprogess';
// String deliveryboysListUrl(String villageId) =>
//     'customer/api/address/DeliveryBoysByVillageId?villageId=$villageId';
// String cancelAndCompleterOrder(String orderId, String orderType) =>
//     'customer/api/orders/$orderId/$orderType';
// const salesAndEarnings = 'customer/api/admin/agents/stats/by-date';
// const onTheWayDeliveryUrl = 'customer/api/orders/updateOnTheWay';

// //products
// const groupedProducts = 'customer/api/products/grouped';
// String getProductsbyAddressId(String addressId) =>
//     'customer/api/products/products/by-village?addressId=$addressId';
// const updateProductDetailsUrl = 'customer/api/products/update-or-create';

// //location
// String districtMandalListUrl(int pincode) =>
//     'customer/api/address/villagesByPicode?pincode=$pincode';
// const addAddressUrl = 'customer/api/address/addAddress';

// //scratchcards
// const getDailyScratchCardsListUrl = 'customer/scratch-cards/today';
// const scratchCardClaimUrl = 'customer/scratch-cards/scratch';
// const weeklyScratchCards = 'api/customer/scratch-cards/week';

// //sales
// const adminAndSystemUserSalesUrl = 'customer/api/admin/agents/stats/by-date';
