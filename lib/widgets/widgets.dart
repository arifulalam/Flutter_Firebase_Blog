import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinKit(String name, {color = Colors.cyan, size = 25.0}) {
  switch (name) {
    case 'FadingCircle':
      return SpinKitFadingCircle(
        color: color,
        size: size,
      );
    case 'RotatingPlain':
      return SpinKitRotatingPlain(
        color: color,
        size: size,
      );
    case 'DoubleBounce':
      return SpinKitDoubleBounce(
        color: color,
        size: size,
      );
    case 'Wave':
      return SpinKitWave(
        color: color,
        size: size,
      );
    case 'WanderingCubes':
      return SpinKitWanderingCubes(
        color: color,
        size: size,
      );
    case 'FadingFour':
      return SpinKitFadingFour(
        color: color,
        size: size,
      );
    case 'FadingCube':
      return SpinKitFadingCube(
        color: color,
        size: size,
      );
    case 'CubeGrid':
      return SpinKitCubeGrid(
        color: color,
        size: size,
      );
    case 'Circle':
      return SpinKitCircle(
        color: color,
        size: size,
      );
    case 'ThreeBounce':
      return SpinKitThreeBounce(
        color: color,
        size: size,
      );
    case 'ChasingDots':
      return SpinKitChasingDots(
        color: color,
        size: size,
      );
    case 'Pulse':
      return SpinKitPulse(
        color: color,
        size: size,
      );
    case 'RotatingCircle':
      return SpinKitRotatingCircle(
        color: color,
        size: size,
      );
    case 'FoldingCube':
      return SpinKitFoldingCube(
        color: color,
        size: size,
      );
    case 'PumpingHeart':
      return SpinKitPumpingHeart(
        color: color,
        size: size,
      );
    case 'HourGlass':
      return SpinKitHourGlass(
        color: color,
        size: size,
      );
    case 'PouringHourGlass':
      return SpinKitPouringHourGlass(
        color: color,
        size: size,
      );
    case 'PouringHourGlassRefined':
      return SpinKitPouringHourGlassRefined(
        color: color,
        size: size,
      );
    case 'SquareCircle':
      return SpinKitSquareCircle(
        color: color,
        size: size,
      );
    case 'SpinningLines':
      return SpinKitSpinningLines(
        color: color,
        size: size,
      );
    case 'SpinningCircle':
      return SpinKitSpinningCircle(
        color: color,
        size: size,
      );
    case 'Ripple':
      return SpinKitRipple(
        color: color,
        size: size,
      );
    case 'Ring':
      return SpinKitRing(
        color: color,
        size: size,
      );
    case 'FadingGrid':
      return SpinKitFadingGrid(
        color: color,
        size: size,
      );
    case 'DualRing':
      return SpinKitDualRing(
        color: color,
        size: size,
      );
    case 'PianoWave':
      return SpinKitPianoWave(
        color: color,
        size: size,
      );
    case 'DancingSquare':
      return SpinKitDancingSquare(
        color: color,
        size: size,
      );
    case 'ThreeInOut':
      return SpinKitThreeInOut(
        color: color,
        size: size,
      );
    default:
      return SpinKitFadingCircle(
        color: color,
        size: size,
      );
  }
}
