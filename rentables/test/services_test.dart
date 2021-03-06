import 'dart:math';
import 'package:logger/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:rentables/rentables.dart';

void main() {
  Logger.level = Level.debug;

  group('Services', () {
    test('Get Icons by Name', () async {
      expect(() => getIconByName('kjbsdciugcsd'), throwsException);
      for (var _icon in availableIcons) {
        expect(getIconByName(_icon, color: Colors.white).color, Colors.white);
      }
    });
    test('Get Colors by Name', () async {
      expect(() => getColorByName('kjbsdciugcsd'), throwsException);
      expect(getColorByName('black'), Colors.black);
      expect(getColorByName('white'), Colors.white);
    });
  });

  group('Local Id Generator', () {
    test('Create new ID', () async {
      var _localIdGen = LocalIdGenerator(keyIndex: 526177, keyLength: 4);
      expect(_localIdGen.getId(), 'ba01');
      _localIdGen = LocalIdGenerator(keyIndex: 0, keyLength: 4);
      expect(_localIdGen.getId(), '0000');
      _localIdGen = LocalIdGenerator(keyIndex: 1, keyLength: 4);
      expect(_localIdGen.getId(), '0001');
      _localIdGen = LocalIdGenerator(keyIndex: pow(36, 4) - 1, keyLength: 4);
      expect(_localIdGen.getId(), 'zzzz');
      _localIdGen = LocalIdGenerator(keyIndex: 119376, keyLength: 4);
      expect(_localIdGen.getId(), '2k40');
      _localIdGen = LocalIdGenerator(keyLength: 8, keyIndex: pow(36, 8) - 2);
      expect(_localIdGen.getId(), 'zzzzzzzy');
    });

    test('Hive ID', () async {
      var _localIdGen = LocalIdGenerator(keyLength: 4);
      expect(_localIdGen.getHiveIdFromString('ba01'), 526177);
      expect(_localIdGen.getHiveIdFromString('0000'), 0);
      expect(_localIdGen.getHiveIdFromString('0001'), 1);
      expect(_localIdGen.getHiveIdFromString('zzzz'), pow(36, 4) - 1);
      expect(_localIdGen.getHiveIdFromString('2k40'), 119376);
      _localIdGen = LocalIdGenerator(keyLength: 8);
      expect(_localIdGen.getHiveIdFromString('zzzzzzzy'), pow(36, 8) - 2);
    });
  });
}
