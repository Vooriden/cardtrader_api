// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobStats _$JobStatsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JobStats', json, ($checkedConvert) {
      final val = JobStats(
        ok: $checkedConvert('ok', (v) => (v as num).toInt()),
        warning: $checkedConvert('warning', (v) => (v as num).toInt()),
        error: $checkedConvert('error', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JobStatsToJson(JobStats instance) => <String, dynamic>{
  'ok': instance.ok,
  'warning': instance.warning,
  'error': instance.error,
};

JobResult _$JobResultFromJson(Map<String, dynamic> json) => $checkedCreate(
  'JobResult',
  json,
  ($checkedConvert) {
    final val = JobResult(
      result: $checkedConvert('result', (v) => v as String),
      jobIndex: $checkedConvert('job_index', (v) => (v as num).toInt()),
      productId: $checkedConvert('product_id', (v) => (v as num?)?.toInt()),
      errors: $checkedConvert('errors', (v) => v as Map<String, dynamic>?),
      warnings: $checkedConvert('warnings', (v) => v as Map<String, dynamic>?),
    );
    return val;
  },
  fieldKeyMap: const {'jobIndex': 'job_index', 'productId': 'product_id'},
);

Map<String, dynamic> _$JobResultToJson(JobResult instance) => <String, dynamic>{
  'result': instance.result,
  'job_index': instance.jobIndex,
  'product_id': ?instance.productId,
  'errors': ?instance.errors,
  'warnings': ?instance.warnings,
};

Job _$JobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Job', json, ($checkedConvert) {
      final val = Job(
        uuid: $checkedConvert('uuid', (v) => v as String?),
        state: $checkedConvert('state', (v) => v as String),
        spawnedChildren: $checkedConvert(
          'spawned_children',
          (v) => (v as num?)?.toInt(),
        ),
        stats: $checkedConvert(
          'stats',
          (v) => JobStats.fromJson(v as Map<String, dynamic>),
        ),
        results: $checkedConvert(
          'results',
          (v) => (v as List<dynamic>)
              .map((e) => JobResult.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'spawnedChildren': 'spawned_children'});

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
  'uuid': ?instance.uuid,
  'state': instance.state,
  'spawned_children': ?instance.spawnedChildren,
  'stats': instance.stats.toJson(),
  'results': instance.results.map((e) => e.toJson()).toList(),
};
