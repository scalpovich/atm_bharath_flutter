import 'package:atm_flutter_app/constants/prefs_constants.dart';
import 'package:get_storage/get_storage.dart';

class PrefManager {
  final box = GetStorage();

  String? get getDeviceId => box.read(PrefsConstants.deviceId);
  void setDeviceId(String deviceId) =>
      box.write(PrefsConstants.deviceId, deviceId);

  String? get getCustomerCode => box.read(PrefsConstants.customerCode);
  void setCustomerCode(String customerCode) =>
      box.write(PrefsConstants.customerCode, customerCode);

  String? get getWalletMoney => box.read(PrefsConstants.walletMoney);
  void setWalletMoney(String walletMoney) =>
      box.write(PrefsConstants.walletMoney, walletMoney);

  String? get getCustomerName => box.read(PrefsConstants.customerName);
  void setCustomerName(String customerName) =>
      box.write(PrefsConstants.customerName, customerName);

  String? get getShopGstNo => box.read(PrefsConstants.shopGstNo);
  void setShopGstNo(String shopGstNo) =>
      box.write(PrefsConstants.shopGstNo, shopGstNo);

  String? get getUserType => box.read(PrefsConstants.userType);
  void setUserType(String userType) =>
      box.write(PrefsConstants.userType, userType);

  String? get getDriverName => box.read(PrefsConstants.driverName);
  void setDriverName(String? driverName) =>
      box.write(PrefsConstants.driverName, driverName);

  String? get getDriverCode => box.read(PrefsConstants.driverCode);
  void setDriverCode(String driverCode) =>
      box.write(PrefsConstants.driverCode, driverCode);

  String? get getDriverDutyStatus => box.read(PrefsConstants.driverStatus);
  void setDriverDutyStatus(String driverStatus) =>
      box.write(PrefsConstants.driverStatus, driverStatus);

  String? get getCustomerMobile => box.read(PrefsConstants.customerMobile);
  void setCustomerMobile(String customerMobile) =>
      box.write(PrefsConstants.customerMobile, customerMobile);

  String? get getCustomerEmail => box.read(PrefsConstants.customerEmail);
  void setCustomerEmail(String customerEmail) =>
      box.write(PrefsConstants.customerEmail, customerEmail);

  String? get getShopAddress => box.read(PrefsConstants.shopAddress);
  void setShopAddress(String shopAddress) =>
      box.write(PrefsConstants.shopAddress, shopAddress);

  String? get getShopAddressLine => box.read(PrefsConstants.shopAddressLine);
  void setShopAddressLine(String shopAddressLine) =>
      box.write(PrefsConstants.shopAddressLine, shopAddressLine);

  String? get getLockingAmount => box.read(PrefsConstants.lockingAmount);
  void setLockingAmount(String lockingAmount) =>
      box.write(PrefsConstants.lockingAmount, lockingAmount);

  String? get getEncryptedCustomerCode =>
      box.read(PrefsConstants.encryptCustomerCode);
  void setEncryptedCustomerCode(String encryptedCustomerCode) =>
      box.write(PrefsConstants.encryptCustomerCode, encryptedCustomerCode);

  String? get getEncryptedDriverCode =>
      box.read(PrefsConstants.encryptDriverCode);
  void setEncryptedDriverCode(String encryptedDriverCode) =>
      box.write(PrefsConstants.encryptDriverCode, encryptedDriverCode);

  bool? get getLoginFlag => box.read(PrefsConstants.loginFlag);
  void setLoginFlag(bool flag) => box.write(PrefsConstants.loginFlag, flag);

  bool? get getLogFlag => box.read(PrefsConstants.logFlag);
  void setLogFlag(bool flag) => box.write(PrefsConstants.logFlag, flag);

  bool? get getBBPS => box.read(PrefsConstants.bbps);
  void setBBPS(bool? flag) => box.write(PrefsConstants.bbps, flag ?? false);

  bool? get getMoneyTransfer => box.read(PrefsConstants.moneyTransfer);
  void setMoneyTransfer(bool? flag) =>
      box.write(PrefsConstants.moneyTransfer, flag ?? false);

  bool? get getQR => box.read(PrefsConstants.qr);
  void setQR(bool? flag) => box.write(PrefsConstants.qr, flag ?? false);

  bool? get getDoorStep => box.read(PrefsConstants.doorStep);
  void setDoorStep(bool? flag) =>
      box.write(PrefsConstants.doorStep, flag ?? false);

  String? get getBBBPSPassword => box.read(PrefsConstants.bbpsPassword);
  void setBBPSPassword(String password) =>
      box.write(PrefsConstants.bbpsPassword, password);

  String? get getMoneyTransferPassword =>
      box.read(PrefsConstants.moneyTransferPassword);
  void setMoneyTransferPassword(String password) =>
      box.write(PrefsConstants.moneyTransferPassword, password);

  String? get getQRPassword => box.read(PrefsConstants.qrPassword);
  void setQRPassword(String password) =>
      box.write(PrefsConstants.qrPassword, password);

  String? get getDoorStepPassword => box.read(PrefsConstants.doorStepPassword);
  void setDoorStepPassword(String password) =>
      box.write(PrefsConstants.doorStepPassword, password);

  String? get getBaseUrl => box.read(PrefsConstants.baseUrl);
  void setBaseUrl(String baseUrl) => box.write(PrefsConstants.baseUrl, baseUrl);

  String? get getQRTimeout => box.read(PrefsConstants.qrTimeout);
  void setQRTimeout(String qrTimeout) =>
      box.write(PrefsConstants.qrTimeout, qrTimeout);

  String? get getSyncDuration => box.read(PrefsConstants.syncDurationPeriod);
  void setSyncDuration(String duration) =>
      box.write(PrefsConstants.syncDurationPeriod, duration);

  String? get getTimeoutTime => box.read(PrefsConstants.serverTimeoutTime);
  void setTimeoutTime(String time) =>
      box.write(PrefsConstants.serverTimeoutTime, time + '000');

  bool? get getSyncFlag => box.read(PrefsConstants.syncFlag);
  void setSyncFlag(bool flag) => box.write(PrefsConstants.syncFlag, flag);

  bool? get getNewUserFlag => box.read(PrefsConstants.appFirstTimeOpened);
  void setNewUserFlag(bool flag) =>
      box.write(PrefsConstants.appFirstTimeOpened, flag);

  String? get getLanguage => box.read(PrefsConstants.appLanguage);
  void setLanguage(String language) =>
      box.write(PrefsConstants.appLanguage, language);

  String? get getTheme => box.read(PrefsConstants.appTheme);
  void setTheme(String? theme) => box.write(PrefsConstants.appTheme, theme);
}
