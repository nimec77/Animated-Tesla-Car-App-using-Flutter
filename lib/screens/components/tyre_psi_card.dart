import 'package:flutter/material.dart';
import 'package:tesla_animated_app/constants.dart';
import 'package:tesla_animated_app/models/tyre_psi.dart';

class TyrePsiCard extends StatelessWidget {
  const TyrePsiCard({
    Key? key,
    required this.isBottomTwoTyre,
    required this.tyrePsi,
  }) : super(key: key);

  final bool isBottomTwoTyre;
  final TyrePsi tyrePsi;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: tyrePsi.isLowPressure ? redColor.withOpacity(0.1) : Colors.white10,
        border: Border.all(
          color: tyrePsi.isLowPressure ? redColor : primaryColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: isBottomTwoTyre
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LowPressureText(),
          const Spacer(),
          PsiText(psi: tyrePsi.psi.toString()),
          const SizedBox(height: defaultPadding),
          Text(
            '${tyrePsi.temp}\u2103',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PsiText(psi: tyrePsi.psi.toString()),
          const SizedBox(height: defaultPadding),
          Text(
            '${tyrePsi.temp}\u2103',
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          const LowPressureText(),
        ],
      ),
    );
  }
}

class LowPressureText extends StatelessWidget {
  const LowPressureText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Low'.toUpperCase(),
          style: Theme.of(context).textTheme.headline3!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Pressure'.toUpperCase(),
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class PsiText extends StatelessWidget {
  const PsiText({
    Key? key,
    required this.psi,
  }) : super(key: key);

  final String psi;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: psi,
        style: Theme.of(context).textTheme.headline4!.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        children: const [
          TextSpan(
            text: 'psi',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
