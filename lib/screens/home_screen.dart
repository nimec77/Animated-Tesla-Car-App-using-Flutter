import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_animated_app/constants.dart';
import 'package:tesla_animated_app/home_controller.dart';
import 'package:tesla_animated_app/screens/components/battery_status.dart';
import 'package:tesla_animated_app/screens/components/door_lock.dart';
import 'package:tesla_animated_app/screens/components/tesla_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late final AnimationController _batteryAnimationController;
  late final Animation<double> _animationBattery;
  late final Animation<double> _animationBatteryStatus;

  @override
  void initState() {
    _setupBatteryAnimation();
    super.initState();
  }

  void _setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0, 0.5),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _batteryAnimationController]),
      builder: (context, child) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {
              if (index == 1) {
                _batteryAnimationController.forward();
              } else if (_controller.selectedBottomTab == 1 && index != 1) {
                _batteryAnimationController.reverse(from: 0.7);
              }
              _controller.onBottomNavigationTabChange(index);
            },
            selectedTab: _controller.selectedBottomTab,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.1),
                      child: SvgPicture.asset(
                        'assets/icons/car.svg',
                        width: double.infinity,
                      ),
                    ),
                    AnimatedPositioned(
                      duration: kDefaultDuration,
                      right:
                          _controller.selectedBottomTab == 0 ? constraints.maxWidth * 0.05 : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: kDefaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLock,
                          press: _controller.updateRightDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: kDefaultDuration,
                      left: _controller.selectedBottomTab == 0 ? constraints.maxWidth * 0.05 : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: kDefaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLock,
                          press: _controller.updateLeftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: kDefaultDuration,
                      top:
                          _controller.selectedBottomTab == 0 ? constraints.maxHeight * 0.13 : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: kDefaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isBonnetLock,
                          press: _controller.updateBonnetDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: kDefaultDuration,
                      bottom:
                          _controller.selectedBottomTab == 0 ? constraints.maxHeight * 0.17 : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: kDefaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isTrunkLock,
                          press: _controller.updateTrunkLock,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        'assets/icons/battery.svg',
                        width: constraints.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(constraints: constraints),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
