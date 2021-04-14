import 'package:counting_set/src/empty_immutable_counting_set.dart';

/// A [Set] that remembers how many times an element was added, and requires
/// that element to be removed that many times before it's actually removed.
///
/// When elements are added, they replace existing equal elements (instead of
/// doing nothing).
abstract class CountingSet<E> implements Set<E> {
  const CountingSet();

  /// An empty, immutable [CountingSet].
  const factory CountingSet.immutable() = EmptyImmutableCountingSet;

  /// Values in the set, mapped to the number of times they've been added.
  ///
  /// The returned map may be updated; make a copy if you don't want the data to
  /// change.
  Map<E, int> get counts;

  /// Adds [value] to the set.
  ///
  /// Returns `true` if [value] (or an equal value) was not yet in the set.
  /// Otherwise returns `false` and the required removal counter is incremented.
  ///
  /// If a value equal to [value] was already in the set, it is replaced with
  /// [value].
  @override
  bool add(E value);

  /// Adds the given values with counts.
  ///
  /// For example, `addCounts({'example': 2})` would add 'example' to the set
  /// and require it to be removed twice to actually be removed from the set.
  void addCounts(Map<E, int> counts);

  /// Removes [value] from the set.
  ///
  /// Returns `true` if [value] was in the set, and `false` if not.
  /// The method has no effect if [value] was not in the set.
  ///
  /// If [value] requires removal multiple times, the required removal counter
  /// is decremented. Otherwise, [value] is removed.
  @override
  bool remove(Object? value);
}
