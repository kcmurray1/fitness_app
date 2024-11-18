import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// Retrieve and update user data using json types
class JsonStorage
{
  final String fileName;
  final dynamic defaultValue;

  dynamic _cache;

  JsonStorage({
      required this.fileName,
      this.defaultValue = const {},
  });

  dynamic get cache {
    return _cache;
  }

  Future<File> get _localFile async {
    Directory directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/${fileName}');
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
      final File file = await _localFile;
      final String content = await file.readAsString();
      _cache = jsonDecode(content);
    }
    catch(e)
    {
      _cache = {};
    }

    if(_cache.isEmpty)
    {
      _cache["default"] = defaultValue;
    }
    print("read $_cache");
    return _cache;
  }

  /// Write _cache to file <br>
  /// Does not do anything if error occurs
  Future<File> save() async
  {
     final File file = await _localFile;

    print("json_storage saving: $_cache");
    // _cache = jsonEncode(data);
    return file.writeAsString(jsonEncode(_cache));
  }
  
  dynamic clear()
  {
    _cache!.clear();
    return _cache;
  }

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