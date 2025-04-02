import 'dart:io';

String fixtures(String name) => File('test/fixture/$name').readAsStringSync();
