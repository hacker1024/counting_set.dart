# Counting Set
A Dart package providing a set that requires an element to be removed as many
times as it was added.

When an item that already is in the set is added, it replaces the existing
value. This is useful for sets with custom equality functions.

## Usage
```dart
import 'package:counting_set/counting_set.dart';

void main() {
  final set = CountingHashSet<String>();
  set.add('example');
  set.add('example');
  set.remove('example');
  print(set.contains('example')); // true
  set.remove('example');
  print(set.contains('example')); // false
}
```

## Notes
- `CountingHashSet` implements `Set`, but that does not mean it can be used with
  all code that expects a regular `Set`. Be careful. `toSet` will generate a
  normal `Set` if need be.
  
## License
```
MIT License

Copyright (c) 2021 hacker1024

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```