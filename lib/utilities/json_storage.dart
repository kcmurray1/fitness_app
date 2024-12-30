import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// Retrieve and update user data using json types
/// [JsonStorage] uses [JsonStorage._cache] attribute to reduce file reads/writes
/// 
/// Must use [JsonStorage.save] to save to file
class JsonStorage
{
  final String fileName;
  final dynamic defaultValue;
  final dynamic defaultKey;

  dynamic _cache;

  JsonStorage({
      required this.fileName,
      this.defaultValue = const {},
      this.defaultKey
  });

  dynamic get cache {
    return _cache;
  }

  Future<File> _localFile({String? name}) async {
    Directory directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/${name ?? fileName}');
  }

  /// Return read json content from storage
  /// Returns [defaultValue] if no content is read or
  /// an error occurs while reading
  Future<dynamic> read() async
  {
    if(_cache != null)
    {
      return _cache;
    }
 
    try
    {
      final File file = await _localFile();
      final String content = await file.readAsString();
      _cache = jsonDecode(content);
    }
    catch(e)
    {
      _cache = {};
    }

    if(_cache.isEmpty)
    {
      _cache[defaultKey ?? "default"] = defaultValue;
    }
    return _cache;
  }

  /// Write _cache to file <br>
  /// Does not do anything if error occurs
  Future<File> save({String? name}) async
  {
     final File file = await _localFile(name: name);
    
    return file.writeAsString(jsonEncode(_cache));
  }
  
  /// Clears [_cache]
  /// 
  /// NOTE: does not save changes unless [JsonStorage.save] is called
  dynamic clear()
  {
    _cache!.clear();
    return _cache;
  }

  /// Removes key-value pair from storage. Does nothing if key does not exist
  dynamic remove(String key)
  {
    return _cache?.remove(key);
  }
  
  operator []=(String key, dynamic value)
  {
    _cache?[key] = value;
  }

  operator [](String key)
  {
    return _cache?[key];
  }
}