import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../config/dio_client.dart';

class DropdownRepository {
  final Dio _dio = DioClient.dio;


  Future<List<Map<String,dynamic>>> getStates() async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      final response = await _dio.get('api/states');
      if(response.statusCode==200){
        return (response.data as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      }
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to load states');
    } catch (e) {
      throw Exception('An unexpected error occurred while getting states');
    }
    return [];
  }



  Future<List<String>> getCities(String stateCode) async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      final response = await _dio.get('api/cities/$stateCode');
      if(response.statusCode==200){
        return List<String>.from(response.data['cities']);
      }
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to load cities');
    } catch (e) {
      throw Exception('An unexpected error occurred while getting cities');
    }
    return [];
  }

  Future<List<String>> getIndoreLocalities() async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      final response = await _dio.get('api/localities/indore');
      if(response.statusCode==200){
        return List<String>.from(response.data);
      }
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to load localities');
    } catch (e) {
      throw Exception('An unexpected error occurred while getting localities');
    }
    return [];
  }

  Future<List<String>> getDegrees() async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      final response = await _dio.get('api/degrees');
      if(response.statusCode==200){
        return List<String>.from(response.data);
      }
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to load degrees');
    } catch (e) {
      throw Exception('An unexpected error occurred while getting degrees');
    }
    return [];
  }

Future<List<String>> getMetroCities() async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      final response = await _dio.get('api/corporate:metro:cities');
      if(response.statusCode==200){
        return List<String>.from(response.data);
      }
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to load metro cities');
    } catch (e) {
      throw Exception('An unexpected error occurred while getting metro cities');
    }
    return [];
  }

  Future<List<String>> getLanguages() async {
    try {
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      final response = await _dio.get('api/languages');
      if(response.statusCode==200){
        return List<String>.from(response.data);
      }
    } on DioException catch (e) {
      _handleDioException(e, 'Failed to load languages');
    } catch (e) {
      throw Exception('An unexpected error occurred while getting languages');
    }
    return [];
  }

  // Fetch all industries
   Future<List<String>> getIndustries() async {
    try{
      // **Add a delay before calling API**
      await Future.delayed(const Duration(seconds: 2));
      final response = await _dio .get('api/industries');
      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      }
    }on DioException catch(e) {
      _handleDioException(e, 'Failed to load industries');
    }
    catch(e){
      throw Exception('An unexpected error occurred while getting industries');
    }
    return [];
  }

  // Fetch job roles for a specific industry
   Future<List<String>> getJobRoles(String industry) async {
    try{
      final response = await _dio.get('api/jobs/$industry');
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        return List<String>.from(data['jobRoles']);
      }
    } on DioException catch(e){
      _handleDioException(e, 'Failed to get Job roles');
    }
    catch(e){
      throw Exception('An unexpected error occurred while getting roles');
    }
      return [];
  }

  void _handleDioException(DioException e, String defaultMessage) {
    if (e.response != null) {
      if (e.response?.statusCode == 502) {
        throw Exception('Server Problem');
      }
      if (e.response?.data != null &&
          e.response!.data.containsKey('code') &&
          e.response!.data['code'] == 1001 &&
          e.response!.data.containsKey('user') &&
          e.response!.data['user'] != null){
        throw e.response!.data;
      }
      debugPrint(e.toString());
      throw Exception(e.response?.data ?? defaultMessage);
    } else if (e.error is SocketException) {
      throw Exception('No Internet Connection');
    } else {
      throw Exception(e);
    }
  }


}