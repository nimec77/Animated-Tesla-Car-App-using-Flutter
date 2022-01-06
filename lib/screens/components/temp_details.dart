import 'package:flutter/material.dart';
import 'package:flutter_tesla/constants.dart';
import 'package:flutter_tesla/home_controller.dart';
import 'package:flutter_tesla/screens/components/temp_button.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempButton(
                  title: 'Cool',
                  svgSrc: 'assets/icons/cool_shape.svg',
                  isActive: _controller.isCoolSelected,
                  press: _controller.updateCoolSelectedTab,
                ),
                const SizedBox(width: defaultPadding),
                TempButton(
                  title: 'Heat',
                  svgSrc: 'assets/icons/heat_shape.svg',
                  isActive: !_controller.isCoolSelected,
                  activeColor: redColor,
                  press: _controller.updateCoolSelectedTab,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_drop_up, size: 48),
              ),
              const Text(
                '20\u2103',
                style: TextStyle(fontSize: 86),
              ),
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_drop_down, size: 48),
              ),
            ],
          ),
          const Spacer(),
          Text('Current Temperature'.toUpperCase()),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inside'.toUpperCase(),
                    style: const TextStyle(color: Colors.white54),
                  ),
                  Text(
                    '20\u2103',
                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(width: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Outside'.toUpperCase()),
                  Text(
                    '20\u2103',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
