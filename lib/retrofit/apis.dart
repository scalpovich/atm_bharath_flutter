// ignore_for_file: constant_identifier_names

class Apis {
  //login
  static const String LOGIN = "GetVerifications";
  //customer profile
  static const String PROFILE = "CustomerProfile";
  //money transfer submitting transaction
  static const String SUBMIT = "PostTransactions";
  //money transfer image uploading
  static const String UPLOAD_IMAGE = "TrnUploadImage";
  //money transfer payment purpose
  static const String PURPOSE = "Getpurpose";
  //money transfer report checking transaction status
  static const String TRANSACTION_STATUS = "CheckTransactionStatus";
  //money transfer ifsc search
  static const String IFSC_SEARCH = "SearchIfsc";
  //money transfer report
  static const String REPORT_LIST = "GetReport";
  //static const String VALIDATE_PAYMENT = "MakePayment";
  //bbps validating biller
  static const String VALIDATE_BILLER = "ValidateBiller";
  //bbps make payment direct payment without validation
  static const String BILLER_PAYMENT = "BillerPayment";
  //bbps getting biller circles
  static const String BILLER_CIRCLE = "GetBillerAndCircles";
  //bbps mobile recharge
  static const String MOBILE_RECHARGE = "MobileRecharge";
  //bbps validate recharge and pay
  static const String VALIDATE_PAY = "BillerRecharge";
//    static const String SUBMIT_COMPLAINT = BASE_URL+"RaiseComplaints";
  //submitting complaints
  static const String SUBMIT_COMPLAINT = "NewComplaint";
  //getting biller category
  static const String OPERATOR_LIST = "SearchBillerCategory";
  //getting complaint lists
  static const String COMPLAINTS_LIST = "ComplaintList";
  //getting mobile operators
  static const String OPERATOR_SERIES = "OperatorSeries";
  //getting mobile recharge plans
  static const String VIEW_PLANS = "RetrievePlans";
  //getting bbps report lists
  static const String BBPS_REPORTS = "Bbps_Report";
  //checking bbps transaction status
  static const String BBPS_CHECK_STATUS = "GetTrnStatusBbps";
  //generating qr code
  static const String QR_CODE_GENERATOR = "QRCodeGeneration";
  //getting qr report list
  static const String QR_REPORT = "QR_Report";
  // checking qr transaction status
  static const String QR_CHECK_STATUS = "QRCheckStatus";
  //checking door step agent duty
  static const String AGENT_DUTY = "SwitchDuty";
  //door step pending order lists
  static const String DOOR_STEP_PENDING_ORDER = "PendingOrdersList";
  // door step completed order lists
  static const String DOOR_STEP_COMPLETED_ORDER = "CompletedOrdersList";
  //door step accepted order lists
  static const String DOOR_STEP_ACCEPTED_ORDER = "AcceptedOrdersList";
  //door step orders  accepted by the agent
  static const String ORDER_ACCEPTED_BY_AGENT = "OrderAcceptByAgent";
  //door step orders rejected by the agent
  static const String ORDER_REJECTED_BY_AGENT = "OrderRejectByAgent";
  //door step order status updating
  static const String ORDER_STATUS_UPDATE = "MerchantStatusUpdate";
  //door step order cancelled by the agent
  static const String ORDER_CANCEL_BY_AGENT = "OrderCancelByAgent";
  //door step order otp verification
  static const String ORDER_VERIFICATION = "OrderVerification";
  //door step agent report lists
  static const String DS_ORDER_REPORT = "DoorStepReport";
  //door step agent location tracking
  static const String AGENT_LOCATION_TRACKING = "LocationTracking_Device";
  //door step agent realtime location tracking
  static const String AGENT_REALTIME_LOCATION_TRACKING = "GetDriverLocation";
  //money transfer timeout transaction getting transaction id by sending trace id to server
  static const String GET_TRANSACTION_ID = "GetTransactionId";
  //money transfer getting bank lists
  static const String SEARCH_BANK = "SearchBank";
  //money transfer search distinctive details by using mobile number search
  static const String MOBILE_SEARCH = "MobileSearch";
  //money transfer search distinctive details by using account no
  static const String ACCOUNT_NO_SEARCH = 'AccountSearch';
  //money transfer search distinctive details by using benef name
  static const String NAME_SEARCH = 'NameSearch';
}
