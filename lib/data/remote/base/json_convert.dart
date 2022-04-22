import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/main.dart';
import 'package:json_annotation/json_annotation.dart';

class Converter<T> implements JsonConverter<T, dynamic> {
  const Converter();

  @override
  T fromJson(dynamic json) {
    try {
      return fromJsonAsT<T>(json);
    } catch (e) {
      logger.d('Unable to parse $json to ${T.runtimeType}\nMessage: $e');
    }
    return json as T;
  }

  @override
  dynamic toJson(T object) {
    try {
      return _getToJson(runtimeType, this);
    } catch (e) {
      logger.d('Unable to parse $object to ${T.runtimeType}\nMessage: $e');
    }
    return object;
  }

  // ignore: unused_element
  T _getFromJson(Type type, dynamic data, dynamic json) {
    switch (type) {
    }
    return data as T;
  }

  T _getToJson(Type type, dynamic data) {
    switch (type) {
    }
    return data as T;
  }

  //Go back to a single instance by type
  dynamic _fromJsonSingle(String type, dynamic _json) {
    final json = _json as Map<String, dynamic>;
    switch (type) {
      case 'CakeResponse':
      case 'CakeResponse?':
        return CakeResponse.fromJson(json);

    }

    logger.e('Parse error: \nType:$type');
    return null;
  }

  //empty list is returned by type
  List? _getListFromType(String type) {
    switch (type) {
      // case 'User':
      //   return <User>[];
    }
    return null;
  }

  M fromJsonAsT<M>(dynamic json) {
    final String type = M.toString();
    if (json is List && type.contains('List<')) {
      final String itemType = type.substring(5, type.length - 2);
      final List? tempList = _getListFromType(itemType);
      for (var itemJson in json) {
        tempList?.add(
          _fromJsonSingle(type.substring(5, type.length - 2), itemJson),
        );
      }
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}
