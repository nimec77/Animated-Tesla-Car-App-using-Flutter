import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tesla/constants.dart';
import 'package:flutter_tesla/home_controller.dart';
import 'package:flutter_tesla/models/tyre_psi.dart';
import 'package:flutter_tesla/screens/components/battery_status.dart';
import 'package:flutter_tesla/screens/components/door_lock.dart';
import 'package:flutter_tesla/screens/components/temp_details.dart';
import 'package:flutter_tesla/screens/components/tesla_bottom_navigation_bar.dart';
import 'package:flutter_tesla/screens/components/tyre_psi_card.dart';
import 'package:flutter_tesla/screens/components/tyres_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late final AnimationController _batteryAnimationController;
  late final Animation<double> _animationBattery;
  late final Animation<double> _animationBatteryStatus;

  late final AnimationController _tempAnimationController;
  late final Animation<double> _animationCarShift;
  late final Animation<double> _animationTempShowInfo;
  late final Animation<double> _animationCoolGlow;

  late final AnimationController _tyreAnimationController;
  late final Animation<double> _animationTyre1Psi;
  late final Animation<double> _animationTyre2Psi;
  late final Animation<double> _animationTyre3Psi;
  late final Animation<double> _animationTyre4Psi;

  late final List<Animation<double>> _tyreAnimations;

  @override
  void initState() {
    _setupBatteryAnimation();
    _setupTempAnimation();
    _setupTyreAnimation();
    _tyreAnimations = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi,
    ];
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

  void _setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  void _setupTyreAnimation() {
    _tyreAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _animationTyre1Psi = CurvedAnimation(parent: _tyreAnimationController, curve: const Interval(0.34, 0.5));
    _animationTyre2Psi = CurvedAnimation(parent: _tyreAnimationController, curve: const Interval(0.5, 0.66));
    _animationTyre3Psi = CurvedAnimation(parent: _tyreAnimationController, curve: const Interval(0.66, 0.82));
    _animationTyre4Psi = CurvedAnimation(parent: _tyreAnimationController, curve: const Interval(0.82, 1));
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _batteryAnimationController,
        _tempAnimationController,
        _tyreAnimationController,
      ]),
      builder: (context, child) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {
              if (index == 1) {
                _batteryAnimationController.forward();
              } else if (_controller.selectedBottomTab == 1 && index != 1) {
                _batteryAnimationController.reverse(from: 0.7);
              }
              if (index == 2) {
                _tempAnimationController.forward();
              } else if (_controller.selectedBottomTab == 2 && index != 2) {
                _tempAnimationController.reverse(from: 0.4);
              }

              if (index == 3) {
                _tyreAnimationController.forward();
              } else if (_controller.selectedBottomTab == 3 && index != 3) {
                _tyreAnimationController.reverse();
              }

              _controller
                ..showTyreController(index)
                ..tyreStatusController(index)
                ..onBottomNavigationTabChange(index);
            },
            selectedTab: _controller.selectedBottomTab,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                    Positioned(
                      left: constraints.maxWidth / 2 * _animationCarShift.value,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          'assets/icons/car.svg',
                          width: double.infinity,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right:
                          _controller.selectedBottomTab == 0 ? constraints.maxWidth * 0.05 : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLock,
                          press: _controller.updateRightDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0 ? constraints.maxWidth * 0.05 : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLock,
                          press: _controller.updateLeftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top:
                          _controller.selectedBottomTab == 0 ? constraints.maxHeight * 0.13 : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isBonnetLock,
                          press: _controller.updateBonnetDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom:
                          _controller.selectedBottomTab == 0 ? constraints.maxHeight * 0.17 : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
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
                    if (_controller.selectedBottomTab == 1)
                      Positioned(
                        top: 50 * (1 - _animationBatteryStatus.value),
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        child: Opacity(
                          opacity: _animationBatteryStatus.value,
                          child: BatteryStatus(constraints: constraints),
                        ),
                      ),
                    Positioned(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      top: 60 * (1 - _animationTempShowInfo.value),
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetails(controller: _controller),
                      ),
                    ),
                    Positioned(
                      right: -180 * (1 - _animationCoolGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isCoolSelected
                            ? Image.asset(
                                'assets/images/cool_glow_2.png',
                                key: UniqueKey(),
                                width: 200,
                              )
                            : Image.asset(
                                'assets/images/hot_glow_4.png',
                                key: UniqueKey(),
                                width: 200,
                              ),
                      ),
                    ),
                    if (_controller.isShowTyre) ...tyres(constraints),
                    if (_controller.isShowTyreStatus)
                      GridView.builder(
                        itemCount: 4,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: defaultPadding,
                          crossAxisSpacing: defaultPadding,
                          childAspectRatio: constraints.maxWidth / constraints.maxHeight,
                        ),
                        itemBuilder: (context, index) => ScaleTransition(
                          scale: _tyreAnimations[index],
                          child: TyrePsiCard(
                            isBottomTwoTyre: index > 1,
                            tyrePsi: demoPsiList[index],
                          ),
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
