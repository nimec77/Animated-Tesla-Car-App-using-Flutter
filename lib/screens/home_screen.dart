import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_animated_app/home_controller.dart';
import 'package:tesla_animated_app/screens/components/door_lock.dart';
import 'package:tesla_animated_app/screens/components/tesla_bottom_navigationbar.dart';

// Next Episode show you the battery tab animation
// Thank you!

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {},
            selectedTab: 0,
          ),
          body: SafeArea(
            child: LayoutBuilder(builder: (context, constrains) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: constrains.maxHeight * 0.1),
                    child: SvgPicture.asset(
                      'assets/icons/car.svg',
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    right: constrains.maxWidth * 0.05,
                    child: DoorLock(
                      isLock: _controller.isRightDoorLock,
                      press: _controller.updateRightDoorLock,
                    ),
                  ),
                  Positioned(
                    left: constrains.maxWidth * 0.05,
                    child: DoorLock(
                      isLock: _controller.isLeftDoorLock,
                      press: _controller.updateLeftDoorLock,
                    ),
                  ),
                  Positioned(
                    top: constrains.maxHeight * 0.13,
                    child: DoorLock(
                      isLock: _controller.isBonnetLock,
                      press: _controller.updateBonnetDoorLock,
                    ),
                  ),
                  Positioned(
                    bottom: constrains.maxHeight * 0.17,
                    child: DoorLock(
                      isLock: _controller.isTrunkLock,
                      press: _controller.updateTrunkLock,
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
