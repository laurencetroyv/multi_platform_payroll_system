import 'package:envied/envied.dart';

part 'env_model.g.dart';

@Envied(path: '.env')
abstract class EnvModel {
  @EnviedField(varName: 'APPWRITE_ENDPOINT', obfuscate: true)
  static final String endpoint = _EnvModel.endpoint;

  @EnviedField(varName: 'APPWRITE_PROJECT', obfuscate: true)
  static final String project = _EnvModel.project;

  @EnviedField(varName: 'DATABASE', obfuscate: true)
  static final String database = _EnvModel.database;

  @EnviedField(varName: 'USERS_COLLECTION', obfuscate: true)
  static final String usersCollection = _EnvModel.usersCollection;

  @EnviedField(varName: 'CASH_ADVANCE_COLLECTION', obfuscate: true)
  static final String cashAdvanceCollection = _EnvModel.cashAdvanceCollection;

  @EnviedField(varName: 'JOB_POSITION_COLLECTION', obfuscate: true)
  static final String jobPositionsCollection = _EnvModel.jobPositionsCollection;

  @EnviedField(varName: 'EMPLOYEE_COLLECTION', obfuscate: true)
  static final String employeeCollection = _EnvModel.employeeCollection;

  @EnviedField(varName: 'PAYMENTS_COLLECTION', obfuscate: true)
  static final String paymentsCollection = _EnvModel.paymentsCollection;

  @EnviedField(varName: 'EMPLOYEE_IDS_COLLECTION', obfuscate: true)
  static final String employeeIdsCollection = _EnvModel.employeeIdsCollection;
}
