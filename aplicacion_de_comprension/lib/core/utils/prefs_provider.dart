import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefsProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final prefsNotifierProvider = StateNotifierProvider<PrefsNotifier, PrefsState>(
  (ref) => PrefsNotifier(ref),
);

class PrefsState {
  final Map<String, dynamic> data;
  PrefsState({this.data = const {}});
}

class PrefsNotifier extends StateNotifier<PrefsState> {
  final Ref ref;

  PrefsNotifier(this.ref) : super(PrefsState());

  Future<void> setString(String key, String value) async {
    final prefs = await ref.read(prefsProvider.future);
    await prefs.setString(key, value);
    state = PrefsState(data: {...state.data, key: value});
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await ref.read(prefsProvider.future);
    await prefs.setInt(key, value);
    state = PrefsState(data: {...state.data, key: value});
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await ref.read(prefsProvider.future);
    await prefs.setBool(key, value);
    state = PrefsState(data: {...state.data, key: value});
  }

  String? getString(String key) {
    return state.data[key] as String?;
  }

  int? getInt(String key) {
    return state.data[key] as int?;
  }

  bool? getBool(String key) {
    return state.data[key] as bool?;
  }

  Future<void> remove(String key) async {
    final prefs = await ref.read(prefsProvider.future);
    await prefs.remove(key);
    state = PrefsState(data: {...state.data}..remove(key));
  }
}