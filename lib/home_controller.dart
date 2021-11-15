import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  bool isRightDoorLock = true;

  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  bool isLeftDoorLock = true;

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  bool isBonnetLock = true;

  void updateBonnetDoorLock() {
    isBonnetLock = !isBonnetLock;
    notifyListeners();
  }

  bool isTrunkLock = true;

  void updateTrunkLock() {
    isTrunkLock = !isTrunkLock;
    notifyListeners();
  }

  int selectedBottomTab = 0;

  void onBottomNavigationTabChange(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  bool isCoolSelected = true;

  void updateCoolSelectedTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  bool isShowTyre = false;

  void showTyreController(int index) {
    if (selectedBottomTab != 3 && index == 3) {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyre = true;
        notifyListeners();
      });
    } else {
      isShowTyre = false;
      notifyListeners();
    }
  }

  bool isShowTyreStatus = false;

  void tyreStatusController(int index) {
    if (selectedBottomTab != 3 && index == 3) {
      isShowTyreStatus = true;
      notifyListeners();
    } else {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyreStatus = false;
        notifyListeners();
      });
    }
  }
}
