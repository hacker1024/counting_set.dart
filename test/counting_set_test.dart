import 'package:counting_set/counting_set.dart';
import 'package:test/test.dart';

void main() {
  group('Creation', () {
    test('Creating an empty set', () {
      final set = CountingHashSet();
      expect(set, isEmpty);
      expect(set.counts, equals(const {}));
    });
    test('Creating a set with .of', () {
      final set = CountingHashSet.of(const [1, 1, 2, 3, 4, 5]);
      expect(set, isNotEmpty);
      expect(set, containsAll(const [1, 2, 3, 4, 5]));
      expect(set.counts, equals(const {1: 2, 2: 1, 3: 1, 4: 1, 5: 1}));
    });
    test('Creating a set with addAll', () {
      final set = CountingHashSet()..addAll(const [1, 1, 2, 3, 4, 5]);
      expect(set, isNotEmpty);
      expect(set, containsAll(const [1, 2, 3, 4, 5]));
      expect(set.counts, equals(const {1: 2, 2: 1, 3: 1, 4: 1, 5: 1}));
    });
    test('Creating a set with a for loop', () {
      final set = CountingHashSet();
      const [1, 1, 2, 3, 4, 5].forEach(set.add);
      expect(set, isNotEmpty);
      expect(set, containsAll(const [1, 2, 3, 4, 5]));
      expect(set.counts, equals(const {1: 2, 2: 1, 3: 1, 4: 1, 5: 1}));
    });
    test('Creating a set with existing count values', () {
      const counts = {1: 6, 2: 7, 3: 8, 4: 9, 5: 10};
      final set = CountingHashSet()..addCounts(counts);
      expect(set, isNotEmpty);
      expect(set.counts, equals(counts));
    });
  });
  group('Equality', () {
    test('Regular equality', () {
      const items = [0, 0, 0, 0, 0, 0, 0];
      assert(items.every((element) => element == 0));
      final map = CountingHashSet<int>()..addAll(items);
      expect(map, hasLength(1));
      expect(map, containsAll(const [0]));
      expect(map, equals(const {0: 1}));
    });
    test('Custom equality', () {
      // Test with custom equality where objects are never equal

      // Create a list of identical items.
      const items = [0, 0, 0, 0, 0, 0, 0];

      // Create a list of unique hash codes.
      final hashCodes = List.generate(
        items.length,
        (index) => index,
        growable: false,
      );

      // Store the next [hashCodes] index to use.
      var hashCodeAccess = 0;

      // Create a map where objects are never equal and hashCodes always differ.
      final map = CountingHashSet<int>(
        equals: (_, __) => false,
        hashCode: (_) {
          if (hashCodeAccess == hashCodes.length) hashCodeAccess = 0;
          return hashCodes.elementAt(hashCodeAccess++);
        },
      )..addAll(items);

      // Even though the items are all the same, they should be considered
      // different.
      expect(map, hasLength(items.length));
      expect(map, isNot(contains(items[0])));
    });
    test('Identical equality', () {
      final existingObject = Object();
      final set = CountingHashSet.identity()
        ..addAll([
          const Object(),
          existingObject,
          Object(),
          const Object(),
          Object(),
        ]);
      expect(set, hasLength(4));
      expect(set, contains(const Object()));
      expect(set, contains(existingObject));
      expect(set, isNot(contains(Object())));
      expect(set.counts.values, containsAll(const [2, 1, 1, 1]));
    });
  });
  group('Mutation', () {
    const mutationIterations = 1000;
    const mutationTestValue = 'test';
    test('Removes after the expected amount of calls', () {
      for (var iteration = 1; iteration <= mutationIterations; ++iteration) {
        final set = CountingHashSet()
          ..addAll(List.filled(iteration, mutationTestValue, growable: false))
          ..removeAll(
              List.filled(iteration - 1, mutationTestValue, growable: false));
        expect(set, contains(mutationTestValue));
        set.remove(mutationTestValue);
        expect(set, isNot(contains(mutationTestValue)));
      }
    });
    test('Clears correctly', () {
      for (var iteration = 1; iteration <= mutationIterations; ++iteration) {
        final set = CountingHashSet()
          ..addAll(List.filled(iteration, mutationTestValue, growable: false))
          ..clear();
        expect(set, isEmpty);
      }
    });
  });
}
