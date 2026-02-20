import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

/// Represents the statistics of a batch job.
///
/// Contains counts for successful, warning, and error results.
@JsonSerializable()
class JobStats {
  /// The number of successful operations.
  final int ok;

  /// The number of operations that completed with warnings.
  final int warning;

  /// The number of operations that failed with errors.
  final int error;

  /// Creates a [JobStats] instance.
  JobStats({required this.ok, required this.warning, required this.error});

  /// Creates a [JobStats] from a JSON map.
  factory JobStats.fromJson(Map<String, dynamic> json) =>
      _$JobStatsFromJson(json);

  /// Converts this [JobStats] to a JSON map.
  Map<String, dynamic> toJson() => _$JobStatsToJson(this);
}

/// Represents an individual result within a batch job.
///
/// Each result corresponds to one product operation in the batch,
/// with information about whether it succeeded, had warnings, or failed.
@JsonSerializable()
class JobResult {
  /// The result status (e.g., "ok", "error", "warning").
  final String result;

  /// The index of this operation within the batch.
  @JsonKey(name: 'job_index')
  final int jobIndex;

  /// The product ID if the operation created or affected a product.
  @JsonKey(name: 'product_id')
  final int? productId;

  /// Error details if the operation failed.
  final Map<String, dynamic>? errors;

  /// Warning details if the operation completed with warnings.
  final Map<String, dynamic>? warnings;

  /// Creates a [JobResult] instance.
  JobResult({
    required this.result,
    required this.jobIndex,
    this.productId,
    this.errors,
    this.warnings,
  });

  /// Creates a [JobResult] from a JSON map.
  factory JobResult.fromJson(Map<String, dynamic> json) =>
      _$JobResultFromJson(json);

  /// Converts this [JobResult] to a JSON map.
  Map<String, dynamic> toJson() => _$JobResultToJson(this);
}

/// Represents a batch job in the CardTrader API.
///
/// Batch operations (bulk create, update, delete) are processed
/// asynchronously. This class represents the job status and results.
///
/// Use [isCompleted], [isPending], [isRunning], and [isUnprocessable]
/// getters to check the current state.
@JsonSerializable()
class Job {
  /// The unique job UUID.
  final String uuid;

  /// The current job state (e.g., "pending", "running", "completed", "unprocessable").
  final String state;

  /// The number of spawned child operations.
  @JsonKey(name: 'spawned_children')
  final int spawnedChildren;

  /// The job's result statistics.
  final JobStats stats;

  /// The list of individual operation results.
  final List<JobResult> results;

  /// Creates a [Job] instance.
  Job({
    required this.uuid,
    required this.state,
    required this.spawnedChildren,
    required this.stats,
    required this.results,
  });

  /// Creates a [Job] from a JSON map.
  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  /// Converts this [Job] to a JSON map.
  Map<String, dynamic> toJson() => _$JobToJson(this);

  /// Whether the job has completed successfully.
  bool get isCompleted => state == 'completed';

  /// Whether the job is pending (not yet started).
  bool get isPending => state == 'pending';

  /// Whether the job is currently running.
  bool get isRunning => state == 'running';

  /// Whether the job could not be processed.
  bool get isUnprocessable => state == 'unprocessable';
}
