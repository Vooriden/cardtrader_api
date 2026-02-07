import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable()
class JobStats {
  final int ok;
  final int warning;
  final int error;

  JobStats({required this.ok, required this.warning, required this.error});

  factory JobStats.fromJson(Map<String, dynamic> json) =>
      _$JobStatsFromJson(json);

  Map<String, dynamic> toJson() => _$JobStatsToJson(this);
}

@JsonSerializable()
class JobResult {
  final String result;
  @JsonKey(name: 'job_index')
  final int jobIndex;
  @JsonKey(name: 'product_id')
  final int? productId;
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? warnings;

  JobResult({
    required this.result,
    required this.jobIndex,
    this.productId,
    this.errors,
    this.warnings,
  });

  factory JobResult.fromJson(Map<String, dynamic> json) =>
      _$JobResultFromJson(json);

  Map<String, dynamic> toJson() => _$JobResultToJson(this);
}

@JsonSerializable()
class Job {
  final String uuid;
  final String state;
  @JsonKey(name: 'spawned_children')
  final int spawnedChildren;
  final JobStats stats;
  final List<JobResult> results;

  Job({
    required this.uuid,
    required this.state,
    required this.spawnedChildren,
    required this.stats,
    required this.results,
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);

  bool get isCompleted => state == 'completed';
  bool get isPending => state == 'pending';
  bool get isRunning => state == 'running';
  bool get isUnprocessable => state == 'unprocessable';
}
